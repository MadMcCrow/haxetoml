# this flakes uses Haxix
{
  description = "Add haxetoml to the flake world";
  inputs = {
    # your friendly local nixpkgs
    nixpkgs = {
      type = "indirect";
      id = "nixpkgs";
    };
    # haxix 
    # contains all you need for Haxe development
    # development branch
    haxix.url = "github:MadMcCrow/haxix/dev";
    
  };
  outputs = { self, nixpkgs, haxix, ... }:
    let
      # default system-agnostic flake implementation :
      flake = system:
      let 
        pkgs = import nixpkgs {inherit system;};
        haxe = haxix.legacyPackages."${system}".haxe;
      in rec {
          packages."${system}" = {
            haxetoml = haxe.buildHaxelib rec {
              version = "0.4.0";
              pname = "haxetoml";
              src = self;
              meta.licences = [ pkgs.lib.licenses.mit ];
              meta.description = "TOML support for haxe";
            };
          };
         
          devShells."${system}".default = pkgs.mkShell {
            inputsFrom = [ packages."${system}".haxetoml ];
            buildInputs = [ packages."${system}".haxetoml ] ++ (with haxix.legacyPackages."${system}"; [haxe hashlink hxcpp]);
          };
        };

    # gen for all systems :
    in builtins.foldl' (x: y: nixpkgs.lib.recursiveUpdate x y) { }
    (map flake [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ]);
}