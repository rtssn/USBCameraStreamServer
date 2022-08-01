#!/bin/sh
python3 server.py > /dev/null 2>&1 &

cd www
rm -Rf *.m3u8 *.ts

ffmpeg -f v4l2 -thread_queue_size 16384 -s 640x480 -i /dev/video0 \
  -c:v h264_v4l2m2m -b:v 2000k -bufsize 2000k \
  -flags +cgop+loop-global_header \
  -bsf:v h264_mp4toannexb \
  -f segment -segment_format mpegts -segment_time 5 -segment_list stream.m3u8 segment%06d.ts


#ffmpeg -f v4l2 -thread_queue_size 16384 -s 640x480 -i /dev/video0 -re -ar 8k -ac 2 -c:a pcm_s16le -f s16le -ac 2 -i /dev/zero \
# -c:v h264_v4l2m2m -c:a copy -b:a 64k -g 60 \
# -flags +cgop+global_header \
#  -f hls \
#  -hls_time 2 -hls_list_size 3 -hls_allow_cache 0 \
#  -hls_segment_filename stream_%d.ts \
#  -hls_base_url stream/ \
#  -hls_flags delete_segments \
#  stream.m3u8
