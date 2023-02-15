{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkgconfig
, python3
}:

stdenv.mkDerivation {
  name = "luv";
  src = fetchFromGitHub {
    owner = "luvit";
    repo = "luv";
    rev = "e8e7b7e13225348a8806118a3ea9e021383a9536";
    hash = "sha256-BzRFnQa+o8Ali+Ysp3HXxP6tKeGxBWKCPGVhC4gASV4=";
    fetchSubmodules = true;
  };

  cmakeFlags = [ ];

  nativeBuildInputs = [
    cmake
    pkgconfig
    python3
  ];

  buildInputs = [ ];
}
