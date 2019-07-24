source .env

if [ -z $DESTROY_ALL_DOCKER_IMAGES_AND_CONTAINERS ]; then
  read -p "Would you like to attempt to destroy all Docker images and containers on your machine? This will remove all images and containers (not just SSCS ones) and can be slow, so only do this if this is your first time running this setup, or you're having difficulties getting the setup working. [y/n] " DESTROY_ALL_DOCKER_IMAGES_AND_CONTAINERS
fi

if [ $DESTROY_ALL_DOCKER_IMAGES_AND_CONTAINERS == "y" ]; then
  docker container stop $(docker container ls -a -q) || true
  docker system prune -a -f --volumes || true
fi
