{config, lib, pkgs, inputs, nix-minecraft, ...}:

{
  options = {
    minecraft.enable = lib.mkEnableOption "enable minecraft";
  };

  config = lib.mkIf config.minecraft.enable {
    nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
    services.minecraft-servers = {
      enable = true;
      eula = true;

      servers = {
        Glib = {
          enable = true;
          autoStart = false;
          package = pkgs.fabricServers.fabric-1_21;

          serverProperties = {
            gamemode = "survival";
            difficulty = "normal";
            simulationDistance = 10;
            view-distance = 8;
            online-mode = false;
            motd = "This server runs on a 10 year old laptop, have fun";
          };

          jvmOpts = "-Xms1028M -Xmx4192M";

          symlinks = {
            "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
              FallingTree = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Fb4jn8m6/versions/uni2ZHB8/FallingTree-1.21-1.21.0.7.jar"; sha512 = "43823be2a6e84e8693ef0a3f322cbc72e35b018dec031688bcdda980dc7aa9e3462a324724646ab7f4820e1594df0300551846ebe946cc4d2c0c119c3af5727a"; };
              Monsters-in-the-closet = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/GMA8jFBD/versions/iBLoBKBc/monsters-in-the-closet-1.0.3%2B1.21.jar"; sha512 = "3050abfa65fa003f0a2230f5e84ac31f4cbcac8ca3fee983df98ed4ddd1f54776a8f11b884c5646f8adba6319916e14a4fb9eeaaeefa5f87617d65a2ecebc204"; };
              RightClickHarvest = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/Cnejf5xM/versions/G8rHINcW/rightclickharvest-fabric-4.3.1%2B1.21.jar"; sha512 = "51b80d1407ad1a294c3b19d2823b6fb36dcdf0ed89d71ff16d0ac680cd9c85439ce2f5a8ba73efb5d9a51b4a40aec5bf460445c0dbd07c1da31361cbeaf8d4df"; };
              Fabric-API = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/oGwyXeEI/fabric-api-0.102.0%2B1.21.jar"; sha512 = "11732c4e36c3909360a24aa42a44da89048706cf10aaafa0404d7153cbc7395ff68a130f7b497828d6932740e004416b692650c3fbcc1f32babd7cb6eb9791d8"; };
              cloth-config = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/9s6osm5g/versions/7jtvrmVP/cloth-config-15.0.130-fabric.jar"; sha512 = "8889378815cd9c645a5a7a8b4d800cf211a4cdfae48c7e005f5f1f630272e909899e304e5c294b4c4c05970171ee7ab594d5b1007086ac14d22db414e83eb60b"; };
              Lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/NTZCh7rb/lithium-fabric-mc1.21-0.13.0.jar"; sha512 = "f5b9ec43c05ac3de29e8bc24e28ae34bc91a48ad1235f70635165a699322dbe2b8c071655b1af392c2fb318bde5bfa4959798b837f3c2885a9a7a1f735680ed1"; };
              FerriteCore = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/wmIZ4wP4/ferritecore-7.0.0-fabric.jar"; sha512 = "0f2f9b5aebd71ef3064fc94df964296ac6ee8ea12221098b9df037bdcaaca7bccd473c981795f4d57ff3d49da3ef81f13a42566880b9f11dc64645e9c8ad5d4f"; };
              AppleSkin = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/fG1xJao0/appleskin-fabric-mc1.21-3.0.5.jar"; sha512 = "32176384779f6e223ce6c68bfa3c505222be0d5a21606a195562b471d29b2f7af253bb42756dd66373475bb75582fc11c72d8bd2f311bd0f0ad06816e4f61a29"; };
              Krypton = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/Acz3ttTp/krypton-0.2.8.jar"; sha512 = "5f8cf96c79bfd4d893f1d70da582e62026bed36af49a7fa7b1e00fb6efb28d9ad6a1eec147020496b4fe38693d33fe6bfcd1eebbd93475612ee44290c2483784"; };
              JamLib = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/IYY9Siz8/versions/7NY3wW64/jamlib-fabric-1.0.11%2B1.21.jar"; sha512 = "6503df7e25a8081aff2946bef6fc7067cc51209d8ee3cb2faaa395967e29dd68c2a2e07b8a21cd747307714c2d21dd568f4c6a2d4eae4917ae5e554e4a26875d"; };
              Architectury-API = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/lhGA9TYQ/versions/afBcyXjI/architectury-13.0.6-fabric.jar"; sha512 = "e1b2aeeb5ce17fe05314814274cc116c8f2aba325f5edc766caaf52445c69c79fd0f3235842d24df11346b3505a5befa5782a95b1992266097e558dd394d715b"; };
            });
          };
        };
      };
    };
  };
}
