p(){
  git pull origin "$(git branch | grep '*' | cut -c 3-)":"$*";
}
