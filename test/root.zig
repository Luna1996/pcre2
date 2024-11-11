const std = @import("std");
const pcre2 = @import("pcre2");

test "capture email address" {
  std.debug.print("\n", .{});
  const pattern = "([A-Za-z0-9]+)@([a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+)";
  const subject = "///pcre2@zig.lang///\nabc@def.ghi///zig@hello.world\n";
  const regex = try pcre2.compile(pattern);
  defer regex.deinit();
  var iter = regex.matchAll(subject);
  while (try iter.next()) |match| {
    defer match.deinit();
    for (0..match.ovec.len) |i| {
      std.debug.print("{d}: {s}\n", .{i, match.get(i)});
    }
  }
}