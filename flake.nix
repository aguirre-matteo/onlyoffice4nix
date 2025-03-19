{
  outputs =
    { self, ... }:
    {
      homeManagerModules = rec {
        onlyoffice4nix = import ./module.nix;
        default = onlyoffice4nix;
      };
      homeManagerModule = self.homeManagerModules.onlyoffice4nix;
    };
}
