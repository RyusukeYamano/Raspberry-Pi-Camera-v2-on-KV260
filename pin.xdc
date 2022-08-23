#Fan Speed Enable
set_property PACKAGE_PIN A12 [get_ports {fan_en_b}]
set_property IOSTANDARD LVCMOS33 [get_ports {fan_en_b}]
set_property SLEW SLOW [get_ports {fan_en_b}]
set_property DRIVE 4 [get_ports {fan_en_b}]

#Raspi Enable HDA09
set_property PACKAGE_PIN F11 [get_ports {rpi_cam_en}]
set_property IOSTANDARD LVCMOS33 [get_ports {rpi_cam_en}]
set_property SLEW SLOW [get_ports {rpi_cam_en}]
set_property DRIVE 4 [get_ports {rpi_cam_en}]