# PlayAtlas Dockerized Linux Server

```
mkdir Saved -m777
docker network create test-atlas
docker run --name redis -d --network test-atlas redis
docker run --name atlas -dt --network test-atlas  \
-v ~/atlas-node/ServerGrid/ServerGrid.json:/atlas/ShooterGame/ServerGrid.json \
-v ~/atlas-node/ServerGrid/ServerGrid.ServerOnly.json:/atlas/ShooterGame/ServerGrid.ServerOnly.json \
-v ~/atlas-node/ServerGrid/ServerGrid/:/atlas/ShooterGame/ServerGrid \
-v ~/atlas-node/Saved/:/atlas/ShooterGame/Saved/ \
-p 5761:5761/udp -p 57561:57561/udp -p 27000:27000 \
antihax/atlas-node \
/run.sh \
Ocean?ServerX=0?ServerY=0?AltSaveDirectoryName=00?ServerAdminPassword=123?MaxPlayers=30?ReservedPlayerSlots=25?QueryPort=57561?Port=5761?SeamlessIP=0.0.0.0 -log -server -NoBattlEye
```