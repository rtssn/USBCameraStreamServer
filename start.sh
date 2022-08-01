#!/bin/sh
python3 server.py > /dev/null 2>&1 &

cd www
rm -Rf ./stream/*

ffmpeg -f v4l2 -thread_queue_size 16384 -s 640x480 -i /dev/video0 \
  -c:v h264_v4l2m2m -b:v 2000k -bufsize 2000k \
  -flags +cgop+loop-global_header \
  -bsf:v h264_mp4toannexb \
  -f hls \
  -hls_time 10 -hls_list_size 3 -hls_allow_cache 0 -hls_flags delete_segments \
  ./stream/stream.m3u8