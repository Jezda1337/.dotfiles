{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    jetbrains-mono
    ubuntu_font_family
    liberation_ttf
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts

    (nerdfonts.override { fonts = [ "JetBrainsMono" "MartianMono" "GeistMono" "NerdFontsSymbolsOnly" ]; })
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [  "Liberation Serif" "Vazirmatn" ];
      sansSerif = [ "Ubuntu" "Vazirmatn" ];
      monospace = [ "JetBrainsMono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
