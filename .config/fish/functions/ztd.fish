function ztd -a file
    pandoc $file -f markdown -t pdf | zathura -
end
