size=[320x320]

check_im=( $(ls /usr/local/Cellar/ | grep imagemagick) )

if [ -e $check_im ]
then
  echo "imagemagick non found. Would you like to install it y/n"
  read ANSW
  if [[ "y" = "$ANSW" || "Y" = "$ANSW" ]] ; 
  then
  brew install imagemagick
fi

else
  if [ -z $1 ]
  then
    for fullpath in `ls *.jpg | grep -v _thumbnail.jpg`
    do
    x_size="$(file ${fullpath} | awk '{print $18}' | cut -d x -f 1)"
    y_size="$(file ${fullpath} | awk '{print $18}' | cut -d x -f 2 | cut -d , -f 1)"
    echo "x=${x_size} y= ${y_size}"
      magick "${fullpath}${size}" "${fullpath%.*}_thumbnail.jpg"
      if [ -e "${fullpath%.*}_thumbnail.jpg" ]
      then 
        echo "${fullpath} converted to ${fullpath%.*}_thumbnail.jpg"
      fi
    done
  else
    if [ -e "${1}" ]
    then
      for fullpath in `cat ${1} | grep .jpg`
        do
          if [ -e "${fullpath}" ]
          then 
            magick "${fullpath}${size}" "${fullpath%.*}_thumbnail.jpg"
            if [ -e "${fullpath%.*}_thumbnail.jpg" ]
            then 
              echo "${fullpath} converted to ${fullpath%.*}_thumbnail.jpg"
            fi
          else
          echo "${fullpath} - no such file"
          fi
        done
    else
    echo "${1} - can't open list"
    fi 
  fi
fi
