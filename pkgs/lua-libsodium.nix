{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkgconfig
, python3
, libsodium
, lua
, luajit
}:

stdenv.mkDerivation {
  name = "lua-libsodium";
  src = fetchFromGitHub {
    owner = "jprjr";
    repo = "luasodium";
    rev = "2503fbf895adf8cfec85c0f8cfb4f7c54431b5f";
    hash = "sha256-BfepACMYI1am8+Ku6cP6RD9b0Z5mz9MZ7YvEFiBPNm4=";
    fetchSubmodules = true;
  };

  postPatch = ''
    echo 'set(LUASODIUM_VERSION "1.0.0")' > LuasodiumVersion
  '';

  cmakeFlags = [ ];

  nativeBuildInputs = [
    cmake
    pkgconfig
    python3
  ];

  buildInputs = [
    libsodium
    lua
    luajit
  ];
}
