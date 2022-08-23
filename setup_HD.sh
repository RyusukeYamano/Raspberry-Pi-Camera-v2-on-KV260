#!/bin/bash -eu

#sudo mkdir /config/device-tree/overlays/rpi
#sudo cp rpi_cam.dtbo /config/device-tree/overlays/rpi/dtbo

# v4l2-ctl -d /dev/v4l-subdev2 --list-subdev-mbus-codes 0


sudo chmod 777 /dev/media0
sudo chmod 777 /dev/video0
sudo chmod 777 /dev/v4l*

echo "### SONY IMX219 Sensor subdev1 ###"
sudo media-ctl -d /dev/media0 --set-v4l2 '"imx219 6-0010":0                   [fmt:SRGGB10_1X10/1920x1080]'

echo "### MIPI CSI2-Rx Subsystem subdev0 ###"
sudo media-ctl -d /dev/media0 --set-v4l2 '"80002000.mipi_csi2_rx_subsystem":0 [fmt:SRGGB10_1X10/1920x1080 field:none]'
sudo media-ctl -d /dev/media0 --set-v4l2 '"80002000.mipi_csi2_rx_subsystem":1 [fmt:SRGGB10_1X10/1920x1080 field:none]'

echo "### Demosaic IP subdev2 ###"
sudo media-ctl -d /dev/media0 --set-v4l2 '"a0010000.v_demosaic":0             [fmt:SRGGB10_1X10/1920x1080 field:none]'
sudo media-ctl -d /dev/media0 --set-v4l2 '"a0010000.v_demosaic":1             [fmt:RBG888_1X24/1920x1080 field:none]'


echo "### Gamma LUT IP subdev3 ###"
sudo media-ctl -d /dev/media0 --set-v4l2 'a0030000.v_gamma_lut":0             [fmt:RBG888_1X24/1920x1080 field:none]'
sudo media-ctl -d /dev/media0 --set-v4l2 'a0030000.v_gamma_lut":1             [fmt:RBG888_1X24/1920x1080 field:none]'
yavta --no-query -w '0x0098c9c1 10' /dev/v4l-subdev1 # Red   gain min 1 max 40 step 1 default 10 current 40
yavta --no-query -w '0x0098c9c2 10' /dev/v4l-subdev1 # Blue  gain min 1 max 40 step 1 default 10 current 40
yavta --no-query -w '0x0098c9c3 10' /dev/v4l-subdev1 # Green gain min 1 max 40 step 1 default 10 current 40


echo "### VPSS: Color Space Conversion (CSC) Only ###"
sudo media-ctl -d /dev/media0 --set-v4l2 '"a0040000.v_proc_ss_csc":0              [fmt:RBG888_1X24/1920x1080 field:none]'
sudo media-ctl -d /dev/media0 --set-v4l2 '"a0040000.v_proc_ss_csc":1              [fmt:RBG888_1X24/1920x1080 field:none]'
#sudo media-ctl -d /dev/media0 --set-v4l2 '"a0040000.v_proc_ss_csc":1              [fmt:VYYUYY8_1X24/1920x1080 field:none]'
yavta -w '0x0098c9a1 90' /dev/v4l-subdev2 # CSC Brightness' min 0 max 100 step 1 default 50 current 80
yavta -w '0x0098c9a2 50' /dev/v4l-subdev2 # CSC Contrast'   min 0 max 100 step 1 default 50 current 55
yavta -w '0x0098c9a3 35' /dev/v4l-subdev2 # CSC Red Gain'   min 0 max 100 step 1 default 50 current 35 
yavta -w '0x0098c9a4 24' /dev/v4l-subdev2 # CSC Green Gain' min 0 max 100 step 1 default 50 current 24 
yavta -w '0x0098c9a5 40' /dev/v4l-subdev2 # CSC Blue Gain'  min 0 max 100 step 1 default 50 current 40 



echo "### VPSS: Scaler Only with CSC ###"
#sudo media-ctl -d /dev/media0 --set-v4l2 '"a0080000.v_proc_ss_scaler":0             [fmt:VYYUYY8_1X24/1920x1080 field:none]'
#sudo media-ctl -d /dev/media0 --set-v4l2 '"a0080000.v_proc_ss_scaler":1             [fmt:VYYUYY8_1X24/1920x1080 field:none]'
sudo media-ctl -d /dev/media0 --set-v4l2 '"a0080000.v_proc_ss_scaler":0              [fmt:RBG888_1X24/1920x1080 field:none]'
sudo media-ctl -d /dev/media0 --set-v4l2 '"a0080000.v_proc_ss_scaler":1              [fmt:RBG888_1X24/1920x1080 field:none]'


## set sensor gain ?
v4l2-ctl --set-ctrl=analogue_gain=120
v4l2-ctl --set-ctrl=digital_gain=400
#v4l2-ctl --set-ctrl=red_gamma_correction_1_0_1_10=10  # min=1 max=40 step=1 default=10 value=10 flags=slider
#v4l2-ctl --set-ctrl=blue_gamma_correction_1_0_1_10=10 # min=1 max=40 step=1 default=10 value=10 flags=slider
#v4l2-ctl --set-ctrl=green_gamma_correction_1_0_1_1=10 # min=1 max=40 step=1 default=10 value=10 flags=slider



echo "### show pipeline ###"
sudo media-ctl -p
sudo v4l2-ctl -d /dev/video0 --list-formats

