typeset -U path
path=( $(cope_path) $ANDROID_HOME "$(ruby -e 'print Gem.user_dir')/bin" ~/.bin $path[@] )
