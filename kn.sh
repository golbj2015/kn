# kn -w write content to repository
# kn -s search content from repository
# kn -g pull from git
# kn -p push to git

# function area
# usage info 
usage(){
   echo "Usage:"
   echo "kn -w write content to repository"
   echo "kn -s search content from repository"
   echo "kn -i list all index"
   echo "kn -g pull from git"
   echo "kn -p push to git"

   exit 0
}

#kn -w 
write(){
   cd ~/knows/git/
    
   gedit log
   sed -i '1s/$/===Donot Touch Me===/g' log
   logfile=`date +%Y%m%d` 
   echo "" >> $logfile
   echo 'start---------------------------------------------------------------------->' >> $logfile
   echo  `date +%H%M%S` >> $logfile
   cat log >> $logfile
   echo "" > log
   mv log~ /tmp 
   echo 'end------------------------------------------------------------------------>' >> $logfile
  
}

#kn -s
search(){
  cd ~/knows/git/
  grep -in $1 * -C100 --color
}

#kn -i
index(){
  cd ~/knows/git/
  if [ "$1" = "" ]; then
       grep -in "===Donot Touch Me===" * | sed -e 's/===Donot Touch Me===//g'  
  else
         grep -in "===Donot Touch Me===" * | sed -e 's/===Donot Touch Me===//g'  |grep -in "$1" --color
  fi

}


#kn -g
pull(){
  cd ~/knows/git/
  git pull
}

#kn -p
push(){
  cd ~/knows/git/

  git add -A
  git commit -m  `date +%H%M%S`
  git push origin master
}

# we have less than 2 arguments. Print the help text:

if [ $# -lt 1 ]; then
  usage
fi

if [ $1 = "-w" ]; then
  write $2
  exit 0
fi
if [ $1 = "-s" ]; then
  search $2
  exit 0
fi

if [ $1 = "-i" ]; then
  index $2
  exit 0
fi

if [ $1 = "-g" ]; then
  pull
  exit 0
fi

if [ $1 = "-p" ]; then
  push
  exit 0
fi
