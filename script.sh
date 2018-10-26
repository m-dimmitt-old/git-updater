ghelp(){
  echo "commands are:
  ghelp   - give help on these commands!
  gpm     - git pull origin master:<yourbranch>
  gpd     - git pull origin dev:<yourbranch>
  gcustom - git pull origin custom:<yourbranch>
  gfinish - git finish
  grevert - git revert
  gParentFork - git pull parentForkRemote master:<yourbranch>
  gAllForks   - onetime - update all forks.
  "
};

##
## In the future this will allow remotes to be passed.
## Additionally forks will automatically get their parent project as a remote.
##
gParentFork(){
  html_url=$(curl -s 'https://api.github.com/repos/michaeldimmitt/gh' | \
    python -c "import sys, json; print json.load(sys.stdin)['parent']['html_url']");
  echo "git remote add forkName $html_url.git";

}

gpm(){ # git pull master:ToCurrentBranch via Temp
  git branch -D temp-copy;
  git checkout -b temp-copy
  git pull origin master:"$(git branch | grep '*' | cut -c 3-)";
  gprompt 'gfinish' 'grevert'
};

gpd(){ # git pull dev:ToCurrentBranch via Temp
  git branch -D temp-copy;
  git checkout -b temp-copy;
  git pull "${1:-origin}" dev:"$(git branch | grep '*' | cut -c 3-)";
  gprompt 'gfinish' 'grevert'
};

gcustom(){ # git pull custom:ToCurrentBranch via Temp
  git branch -D temp-copy;
  git checkout -b temp-copy;
  git pull "${1:-origin}" "$*":"$(git branch | grep '*' | cut -c 3-)";
  gprompt 'gfinish' 'grevert'
};

gfinish(){
  git checkout -;
  git merge temp-copy;
  git branch -D temp-copy;
};

grevert(){
  git checkout temp-copy;
  git checkout -;
  git branch -D temp-copy;
};
gprompt(){
  echo "Merging all the changes into a temp branch. Please resolve all conflicts,
  upon conclusion if everything looks appropriate:

  Use $1

  To abort this attempt and get placed back on the branch that you were on!

  Use $2"

}
