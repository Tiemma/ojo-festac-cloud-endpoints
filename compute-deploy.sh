SERVICE_NAME=todo-dao
DOCKER_NETWORK=esp_net
DOCKER_IMAGE="gcr.io/upheld-coast-222303/endpoints-api-demo:1.0"

# Create the docker network
sudo docker network create --driver bridge $DOCKER_NETWORK

# Build and run the backend container images
sudo docker build -t $DOCKER_IMAGE .

sudo docker run --detach --name=api --net=esp_net $DOCKER_IMAGE


# The --rollout_strategy=managed option configures ESP to use the latest deployed service configuration. 
# When you specify this option, within a minute after you deploy a new service configuration, 
# ESP detects the change and automatically begins using it
sudo docker run \
    --name=esp \
    --detach \
    --publish=80:8080 \
    --net=esp_net \
    gcr.io/endpoints-release/endpoints-runtime:1 \
    --service=$SERVICE_NAME \
    --rollout_strategy=managed \
    --backend=api:8080
