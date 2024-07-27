let configDir = ../config;
in
{
  home.file = {
      ".config/nvim".source = "${configDir}/nvim";
      ".config/hypr".source = "${configDir}/hypr";
  };
}
