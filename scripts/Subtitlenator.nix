{ pkgs }:
# Adds `ass` subtitle files to mkv files and creates subdirectory for copied mkv files. Subtitles aren't burned into mkv, just added to the pool. Nice if you don't have subtitle fuzzy find in your Media Player
pkgs.writeShellScriptBin "Subtitlenator.sh" ''
  mkdir Subbed_"$(basename "$PWD")"

  for i in *.mkv
  do
  file="$(basename "$i" .mkv)"
  (ffmpeg -i "$file.mkv" -i "$file.ass" -map 0 -map 1 -c copy Subbed_"$(basename "$PWD")/$file.mkv")
  done
''
