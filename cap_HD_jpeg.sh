GST_DEBUG=3 \
gst-launch-1.0 -v v4l2src device=/dev/video0 ! \
	video/x-raw,framerate=5/1,width=1920,height=1080 ! \
	jpegenc ! \
	filesink location=hoge.jpeg

