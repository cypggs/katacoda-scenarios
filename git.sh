git pull 
git status
git add *
git rm `git status | grep deleted | awk '{print $2}'`
git commit -m "$1"
git push
