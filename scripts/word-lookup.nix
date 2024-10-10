{ pkgs, lib }:
pkgs.writeShellScriptBin "word-lookup.sh" # bash
  ''
    usage(){
    	echo "Usage: $(basename "$0") [-h]
    	Looks up the definition of currently selected word.
    	-w: Use the wayland clipboard (instead of X11) "

    }

    USEWAYLAND=true

    while getopts 'hw' c
    do
    	case $c in
    		h) usage; exit ;;
    		w) USEWAYLAND=true ;;
    		*) usage; exit 1 ;;
    	esac
    done

    shift $((OPTIND-1))

    if [ $USEWAYLAND = true ]
    then
    	word=$(wl-paste -p)
    else
    	word=$(xclip -o)
    fi

    res=$(curl -s "https://api.dictionaryapi.dev/api/v2/entries/en_US/$word")
    regex=$'"definition":"\K(.*?)(?=")'
    definitions=$(echo "$res" | grep -Po "$regex")
    separatedDefinition=$(sed ':a;N;$!ba;s/\n/\n\n/g' <<< "$definitions")
    ${lib.getExe pkgs.libnotify} --urgency=critical -a "word-lookup" "$word" "$separatedDefinition"
  ''
