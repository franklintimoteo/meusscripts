docker image tag jaula-sid:latest jaula-sid:outdate &&  docker image rm jaula-sid:latest
IDcontainer=$(docker run -d -it jaula-sid:outdate /bin/bash)
docker exec $IDcontainer apt update
docker exec $IDcontainer apt upgrade -y
docker stop $IDcontainer
docker commit $IDcontainer jaula-sid:latest
docker container rm $IDcontainer
docker image rm jaula-sid:outdate
