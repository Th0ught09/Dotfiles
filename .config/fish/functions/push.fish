function push --description 'alias push git add .; git commit -m "push for $(date +%Y%m%dT%H:H%M:%S)"; git push'
  git add .; git commit -m "push for $(date +%Y%m%dT%H:H%M:%S)"; git push $argv
        
end
