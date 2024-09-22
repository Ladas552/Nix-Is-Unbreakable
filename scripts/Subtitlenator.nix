{ pkgs }:
pkgs.writeShellScriptBin "Subtitlenator.sh" ''
  mkdir Subbed_"$(basename "$PWD")"

  for i in *.mkv
  do 
  file="$(basename "$i" .mkv)"
  (ffmpeg -i "$file.mkv" -i "$file.ass" -map 0 -map 1 -c copy Subbed_"$(basename "$PWD")/$file.mkv")
  done
''
