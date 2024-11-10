const std = @import("std");

pub const CodeUnitWidth = enum {
  @"8",
  @"16",
  @"32",
};

pub fn build(b: *std.Build) !void {
  const target = b.standardTargetOptions(.{});
  const optimize = b.standardOptimizeOption(.{});
  const linkage = b.option(std.builtin.LinkMode, "linkage", "whether to statically or dynamically link the library") orelse @as(std.builtin.LinkMode, if (target.result.isGnuLibC()) .dynamic else .static);
  const codeUnitWidth = b.option(CodeUnitWidth, "code-unit-width", "Sets the code unit width") orelse .@"8";

  const copyFiles = b.addWriteFiles();
  _ = copyFiles.addCopyFile(b.path("lib/config.h.generic"), "config.h");
  _ = copyFiles.addCopyFile(b.path("lib/pcre2.h.generic"), "pcre2.h");

  const pcre2_lib = std.Build.Step.Compile.create(b, .{
    .name = b.fmt("pcre2-{s}", .{@tagName(codeUnitWidth)}),
    .root_module = .{
      .target = target,
      .optimize = optimize,
      .link_libc = true,
    },
    .kind = .lib,
    .linkage = linkage,
  });

  if (linkage == .static) {
    try pcre2_lib.root_module.c_macros.append(b.allocator, "-DPCRE2_STATIC");
  }

  pcre2_lib.root_module.addCMacro("PCRE2_CODE_UNIT_WIDTH", @tagName(codeUnitWidth));

  pcre2_lib.addCSourceFile(.{
    .file = copyFiles.addCopyFile(b.path("lib/pcre2_chartables.c.dist"), "pcre2_chartables.c"),
    .flags = &.{
      "-DHAVE_CONFIG_H",
    },
  });

  pcre2_lib.addIncludePath(b.path("lib"));
  pcre2_lib.addIncludePath(copyFiles.getDirectory());

  pcre2_lib.addCSourceFiles(.{
    .files = &.{
      "lib/pcre2_auto_possess.c",
      "lib/pcre2_chkdint.c",
      "lib/pcre2_compile.c",
      "lib/pcre2_compile_class.c",
      "lib/pcre2_config.c",
      "lib/pcre2_context.c",
      "lib/pcre2_convert.c",
      "lib/pcre2_dfa_match.c",
      "lib/pcre2_error.c",
      "lib/pcre2_extuni.c",
      "lib/pcre2_find_bracket.c",
      "lib/pcre2_maketables.c",
      "lib/pcre2_match.c",
      "lib/pcre2_match_data.c",
      "lib/pcre2_newline.c",
      "lib/pcre2_ord2utf.c",
      "lib/pcre2_pattern_info.c",
      "lib/pcre2_script_run.c",
      "lib/pcre2_serialize.c",
      "lib/pcre2_string_utils.c",
      "lib/pcre2_study.c",
      "lib/pcre2_substitute.c",
      "lib/pcre2_substring.c",
      "lib/pcre2_tables.c",
      "lib/pcre2_ucd.c",
      "lib/pcre2_valid_utf.c",
      "lib/pcre2_xclass.c",
    },
    .flags = &.{
      "-DHAVE_CONFIG_H",
      "-DPCRE2_STATIC",
    },
  });

  const pcre2_raw = b.addTranslateC(.{
    .root_source_file = copyFiles.addCopyFile(b.path("lib/pcre2.h.generic"), "pcre2.h"),
    .target = target,
    .optimize = optimize,
  });
  pcre2_raw.defineCMacro("PCRE2_CODE_UNIT_WIDTH", @tagName(codeUnitWidth));

  const pcre2_mod = b.addModule("pcre2", .{
    .root_source_file = b.path("src/root.zig"),
    .target = target,
    .optimize = optimize,
  });

  pcre2_mod.linkLibrary(pcre2_lib);
  pcre2_mod.addImport("c", pcre2_raw.createModule());

  const test_step = b.step("test", "build unit tests executable");
  const pcre2_test = b.addTest(.{
    .root_source_file = b.path("test/root.zig"),
    .target = target,
    .optimize = optimize,
  });
  pcre2_test.root_module.addImport("pcre2", pcre2_mod);
  test_step.dependOn(&b.addInstallArtifact(pcre2_test, .{}).step);
}
