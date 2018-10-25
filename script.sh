# update current branch with specified branch, default is master branch.
bupdate(){
  eval 'git pull $(git branch | grep '*' | cut -c 3-):$*'
}
