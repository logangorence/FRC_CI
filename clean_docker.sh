# This should ONLY be used in a development environment, and will nuke all 
# Docker containers and images that are stored locally.

docker ps -a | sed '1 d' | awk '{print $1}' | xargs -L1 docker rm

docker images -a | sed '1 d' | awk '{print $3}' | xargs -L1 docker rmi -f
