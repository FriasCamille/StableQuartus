# Stable Quartus
This repo is a try to use an stable Quartus Lite for linux in any linux with Docker with functional simulation with model sim and no need of a license.
## Requirements
- Docker installed
- Linux based distro
- X11 
- Quartus installed  (Tested with Quartus-lite-18.1 )
## Instalation
clone and move to the repo
Download and decompress Quartus installer here(Sorry i can't uploaded here) 
### Build the docker
```Bash
docker build -t quartus:18.1 .
```
### Run the docker
```Bash
docker run -it \ # you can add if you are testing --rm \
  --net=host \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v /dev/bus/usb:/dev/bus/usb \
  --privileged \
  -v $(pwd)/proyectos:/workspace \
  -v ./Quartus-lite-18.1.0.625-linux:/installer \ # Change to fit the directory where you decompressed th quartus installer .tar
  quartus:18.1 \
  bash
```
### Install Quartus 
Go to /installer and give permissions to setup.sh with chmod +x 
```Bash
cd /installer
chmod +x setup.sh
```
Run the installer 
```Bash
./setup.sh
```
The GUI will open, you can select the family of your FPGA and other settings for your Quartus.

### Recomendation 
Create a file for all your projects in workspace and move intelFPGA_lite to workspace or never do docker system prune and use docker start -ai <your docker ID> (you can see the id with docker ps -a)
```Bash
mkdir /workspace/projects
mv /root/intelFPGA_lite /workspace/
```
If the USB blaster is not recognized create a rule in host machine with:
```Bash
sudo cp /StableQuartus/51-usbblaster.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
```
then restart the docker
## Running  
Now in your host you can run the docker by:
```Bash
./quartus.sh
```


