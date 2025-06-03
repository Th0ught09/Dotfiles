function mkcd -d 'alias mkcd mkdir $1 and cd $1' -a dir
    mkdir $dir && cd $dir
end
