time=20
H=600
ffmpeg -loop 1 -t $time -i $1 \
       -vf "crop=w=iw:h=$H:x=0:y='(ih-$H)*t/$time'" \
       -r 25 -pix_fmt yuv420p $1$time.mp4
