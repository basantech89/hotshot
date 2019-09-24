read -r -p "Please type the GIT User Name ? " user
ans=true
while $ans; do
  printf "Is the username correct: %s ? Press y|Y for Yes, any other key for No: " "$user"
  case "$config" in
    ["Yy"]) ans=false; break ;;
    *) printf "Please type the correct GIT User Name "
  esac
done
