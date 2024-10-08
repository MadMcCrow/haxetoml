# Haxetoml

## Fork 
This is a fork of codescapade/haxetoml made to work with the latest haxe.
This fork removed the haxe-string dependency and adds supports for hashlink. this is specifically made to work with the heaps engine.

There's also a nix flake if you want to use this as a flake !

## Haxetoml
A Haxe implementation of [TOML v0.1.0](https://github.com/mojombo/toml/blob/master/versions/toml-v0.1.0.md) language.

## Install 
install from source like you would any other haxe library. 

## Usage 
Given `foo.toml`:

```toml
[foo]
a = 1

[foo.bar]
b = ["2", "3"]
```


You can parse it with:

```as3
import sys.io.File;

var toml = File.getContent('foo.toml');
var parser = new haxetoml.TomlParser();

var parsed = parser.parse(toml);

parsed.foo; // => 1
parsed.foo.bar[1]; // => "3"
```

There are also some shortcut methods:

```as3
var fileContent = File.getContent('foo.toml');
var parsed = haxetoml.TomlParser.parseString(fileContent);

// or this shortcut, available on neko, cpp and php:
var parsed = haxetoml.TomlParser.parseFile('foo.toml');
```

## synthetic tests
There's a bunch of synthetic test in `cli_test`
