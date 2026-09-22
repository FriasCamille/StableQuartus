docker run -it --rm \
  --net=host \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v /dev/bus/usb:/dev/bus/usb \
  --privileged \
  -v $(pwd)/proyectos:/workspace \
  quartus:18.1 \
  /workspace/intelFPGA_lite/18.1/quartus/bin/quartus
