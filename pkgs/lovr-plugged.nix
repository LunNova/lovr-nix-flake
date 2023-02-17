{ lib
, lovr
, symlinkJoin
, plugins ? [ ]
}:

symlinkJoin {
  name = "lovr-plugged";
  paths = [ lovr ] ++ [ plugins ];

  # we need lovr bin not to be a link so plugins load from the right place
  postBuild = ''
    rm $out/bin/lovr
    cp ${lovr}/bin/lovr $out/bin/lovr

    for plugin in "$out"/lib/{lua/*,}/*.so; do
      ln -s "$plugin" $out/bin/$(basename "$plugin")
    done
  '';

  meta.mainProgram = "lovr";
}
