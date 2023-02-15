{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkgconfig
, python3
, stt
, lua
, luajit
}:

# FIXME: deepspeech is deprecated, should use stt
# FIXME: luaL_register isn't a thing in 5.1 but we have to use that for luajit?

stdenv.mkDerivation {
  name = "luv";
  src = fetchFromGitHub {
    owner = "bjornbytes";
    repo = "lua-deepspeech";
    rev = "6bf9ffb4c14faaa9813f5b3238f6775764c2d011";
    hash = "sha256-4KyiCfmk8x0Qr56kFmCww8AF3mgxegwJL8myhcfcBa4=";
    fetchSubmodules = true;
  };

  postPatch = ''
    sed -i "s/deepspeech.h/coqui-stt.h/g" lua_deepspeech.c
    sed -i "s/DS_/STT_/g" lua_deepspeech.c
  '';

  cmakeFlags = [
    "-DDEEPSPEECH_PATH=${stt}"
  ];

  nativeBuildInputs = [
    cmake
    pkgconfig
    python3
  ];

  buildInputs = [
    stt
    lua
    luajit
  ];
}
