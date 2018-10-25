p(){
  branchy="$(git branch | grep '*' | cut -c 3-)";
  git pull origin $branchy:master;
}
