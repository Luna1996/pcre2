# PCRE2 for zig
## Description
Simple PCRE2 binding for zig. It will build PCRE2 static library from c sources, then wrap it in few most used functions, which are `compile`, `match` and `matchAll`. Those function can also be invoked with options, documented at <https://www.pcre.org/current/doc/html/index.html>.
## Installation
To add the dependence to your project, run following command at same diractory of your `build.zig.zon` file:
```
zig fetch --save https://github.com/Luna1996/pcre2/archive/main.tar.gz
```
Then, add import to your module by add this line to your `build.zig` file:
```
exe.root_module.addImport("pcre2", b.dependency("pcre2").module("root"));
```
## Usage
See simple example [here](./test/root.zig)