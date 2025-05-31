{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    python311
    python311Packages.numpy
    python311Packages.scipy
    python311Packages.pandas
    python311Packages.jupyter
    python311Packages.torch
    python311Packages.tensorflow
    python311Packages.scikit-learn
    python311Packages.matplotlib
    python311Packages.notebook
  ];
}
