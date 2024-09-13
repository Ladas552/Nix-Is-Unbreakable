{pkgs, lib, config, inputs, ...}:

{

  options.customhm = {
    chromium.enable = lib.mkEnableOption "enable chromium";
  };
  config = lib.mkIf config.customhm.chromium.enable {
    programs.chromium = {
      enable = true;
      commandLineArgs = [
      "--no-default-browser-check"
      ];
      package = pkgs.ungoogled-chromium;
      dictionaries = [
      pkgs.hunspellDictsChromium.en_US
      ];
      extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } #Ublock
      { id = "bkdgflcldnnnapblkhphbgpggdiikppg";} #Duckduckgo
      { id = "lfjnnkckddkopjfgmbcpdiolnmfobflj";} #Custom new Tab
      { id = "ldpochfccmkkmhdbclfhpagapcfdljkj";} #Decentraleyes
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone";} #SponsorBlock
      { id = "dinhbmppbaekibhlomcimjbhdhacoael";} #Adskipper
      ];
    };
  };
}
