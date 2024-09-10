{ pkgs }:
pkgs.writers.writeFishBin "musnow.sh" { } /*fish*/ ''
#Dependencis
#fish,ffmpeg,mpd,mpc
#get current's song url into 'crtl+v' clipvoard
ffprobe -loglevel error -show_entries format_tags=purl -of default=noprint_wrappers=1:nokey=1 ~/Music/(mpc -f %file% current) | xclip -selection clipboard  
''
