#! /bin/bash
echo -n "SocAdv video conversion v1.0\n"

if [ $# -ne 1 ]
then
  echo "Usage: `basename $0` file.avi"
  exit 1
fi


echo Converting $1

HandBrakeCLI -i $1 -t 1 -c1 -o ${1%.*}.m4v -f mp4 -4  -O   --keep-display-aspect   -e x264 -q 20 --vfr  -a 0 -R Auto -D 0 --gain=0 --audio-copy-mask none --audio-fallback ffac3 --verbose=1

ffmpeg -i $1 -pass 1 -an  -passlogfile $1log -f webm ${1%.*}.webmvp8.webm
ffmpeg -y -i $1 -pass 2  -passlogfile $1log -b 320k -qmax 35 -f webm ${1%.*}.webmvp8.webm


ffmpeg2theora -V 320 --two-pass $1 -o ${1%.*}.theora.ogv

echo Done

