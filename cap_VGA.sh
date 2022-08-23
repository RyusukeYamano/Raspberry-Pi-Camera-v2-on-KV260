#!/bin/bash -eu

GST_DEBUG=3 gst-launch-1.0 -v v4l2src device=/dev/video0 ! video/x-raw,framerate=30/1,width=640,height=480 ! \
                                            videoconvert ! video/x-raw,width=640,height=480,format=BGRx ! \
                                            autovideosink sync=true
