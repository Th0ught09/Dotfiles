function ztde -a file
    pandoc $file --template="template.tex" --filter=emoji_filter.js -f markdown -t pdf | zathura -
end
