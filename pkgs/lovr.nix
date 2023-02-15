{ lib
, stdenv
, fetchFromGitHub
, cmake
, libglvnd
, xorg
, libxkbcommon
, pkgconfig
, freetype
, vulkan-headers
, openxr-loader
, glfw
, lua
, luajit
, python3
, addOpenGLRunpath
, autoPatchelfHook
}:

stdenv.mkDerivation {
  name = "lovr";
  src = fetchFromGitHub {
    owner = "bjornbytes";
    repo = "lovr";
    rev = "1bc7af2a3195d9443145549f26e14822c3be2282";
    hash = "sha256-BwjU8TASmV6YxsGIjv5PnpG5WYzcoSc+my3TbkMobWs=";
    fetchSubmodules = true;
  };

  patches = [
    ../lovr-cmake.patch
  ];

  prePatch = ''
    chmod -R 0777 deps/msdfgen
    sed -i 's!RELATIVE !!g' deps/msdfgen/CMakeLists.txt
  '';

  cmakeFlags = [
    "-DLOVR_SYSTEM_GLFW=ON"
    "-DLOVR_SYSTEM_LUA=ON"
    "-DLOVR_SYSTEM_OPENXR=ON"
    "-DCMAKE_SKIP_RPATH=ON"
  ];

  nativeBuildInputs = [
    cmake
    pkgconfig
    python3
    addOpenGLRunpath
    #autoPatchelfHook
  ];

  buildInputs = [
    xorg.libX11
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXrandr
    xorg.libXi
    xorg.libXdmcp
    libglvnd.dev
    libxkbcommon
    freetype
    vulkan-headers
    openxr-loader
    glfw
    lua
    luajit
    stdenv.cc.cc.lib
  ];

  postFixup = ''
    for exe in $out/bin/{lovr,glslangValidator}; do
      echo "adding opengl runpath to $exe"
      addOpenGLRunpath "$exe"
    done
  '';
}
