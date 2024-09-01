{ ... }:
{
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      os.disabled = false;

      package.disabled = true;
    };
  };
}
