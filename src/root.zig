const std = @import("std");
const c = @import("c");
const e = @import("enum.zig");

pub inline fn compile(text: []const u8) e.CompileError!Regex { 
  return try compileWithOptions(text, .{});
}

pub fn compileWithOptions(text: []const u8, options: e.CompileOptions) e.CompileError!Regex {
  var error_code: c_int = undefined;
  var error_offset: usize = undefined;
  if (c.pcre2_compile_8(&text[0], text.len, @bitCast(options), &error_code, &error_offset, null)) |code| {
    return .{.code = code};
  } else {
    const compile_error = compileErrorFromCInt(error_code);
    std.log.err("{s} at {d}.", .{@errorName(compile_error), error_offset});
    return compile_error;
  }
}

pub const Regex = struct {
  const Self = @This();

  code: *c.pcre2_code_8,

  pub inline fn match(self: Self, text: []const u8) e.MatchError!?Match {
    return try matchAllWithOptions(self, text, .{});
  }

  pub fn matchWithOptions(self: Self, text: []const u8, options: e.MatchOptions) e.MatchError!?Match {
    const match_data = c.pcre2_match_data_create_from_pattern_8(self.code, null) orelse return e.MatchError.NoMemory;
    const error_code = c.pcre2_match_8(self.code, &text[0], text.len, 0, @bitCast(options), match_data, null);
    
    if (error_code <= 1) c.pcre2_match_data_free_8(match_data);
    if (error_code == 0) unreachable;
    if (error_code == 1 or error_code == -1) return null;
    if (error_code < 0) return matchErrorFromCInt(error_code);

    const ovec_ptr = c.pcre2_get_ovector_pointer_8(match_data);
    var ovec: [][2]usize = undefined;
    ovec.ptr = @ptrCast(ovec_ptr);
    ovec.len = @intCast(error_code);

    return Match {.text = text, .data = match_data, .ovec = ovec};
  }

  pub fn matchAll(self: Self, text: []const u8) MatchIterator {
    return .{.regex = self, .text = text};
  }

  pub fn matchAllWithOptions(self: Self, text: []const u8, options: e.MatchOptions) MatchIterator {
    return .{.regex = self, .text = text, .options = options};
  }

  pub fn deinit(self: Self) void {
    c.pcre2_code_free_8(self.code);
  }
};

pub const Match = struct {
  const Self = @This();

  text: []const u8,
  data: *c.pcre2_match_data_8,
  ovec: []const [2]usize,

  pub fn get(self: Self, i: usize) []const u8 {
    return self.text[self.ovec[i][0]..self.ovec[i][1]];
  }

  pub fn deinit(self: Self) void {
    c.pcre2_match_data_free_8(self.data);
  }
};

pub const MatchIterator = struct {
  const Self = @This();

  start: usize = 0,
  
  regex: Regex,
  text: []const u8,
  options: e.MatchOptions = .{},

  pub fn next(self: *Self) e.MatchError!?Match {
    if (try self.regex.matchWithOptions(self.text[self.start..], self.options)) |match| {
      self.start += match.ovec[0][1];
      return match;
    } else {
      return null;
    }
  }
};

fn compileErrorFromCInt(code: c_int) e.CompileError {
  return @errorCast(@errorFromInt(@intFromError(e.CompileError.EndBackslash) + @as(u16, @intCast(code - 101))));
}

fn matchErrorFromCInt(code: c_int) e.MatchError {
  return @errorCast(@errorFromInt(@intFromError(e.MatchError.NoMatch) + @as(u16, @intCast(-code - 1))));
}