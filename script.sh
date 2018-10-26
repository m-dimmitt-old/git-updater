ghelp(){
  echo "commands are:
  ghelp   - give help on these commands!
  gpm     - git pull origin master:<yourbranch>
  gpd     - git pull origin dev:<yourbranch>
  gcustom - git pull origin custom:<yourbranch>
  gfinish - git finish
  grevert - git revert
  gParentForkMaster - git pull parentForkRemote master:<yourbranch>"
};

##
## In the future this will allow remotes to be passed.
## Additionally forks will automatically get their parent project as a remote.
##

gpm(){ # git pull master:ToCurrentBranch via Temp
  git branch -D temp-copy;
  git checkout -b temp-copy
  git pull origin master:"$(git branch | grep '*' | cut -c 3-)";
  gprompt 'gfinish' 'grevert'
};

gpd(){ # git pull dev:ToCurrentBranch via Temp
  git branch -D temp-copy;
  git checkout -b temp-copy;
  git pull origin dev:"$(git branch | grep '*' | cut -c 3-)";
  gprompt 'gfinish' 'grevert'
};

gcustom(){ # git pull custom:ToCurrentBranch via Temp
  git branch -D temp-copy;
  git checkout -b temp-copy;
  git pull origin "$*":"$(git branch | grep '*' | cut -c 3-)";
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
