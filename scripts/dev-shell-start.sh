set -e

assert-set PWD USER GOOGLE_APPLICATION_CREDENTIALS DEV_IMAGE_NAME USER

HOME=/home/$USER

docker run \
    -it --rm \
    -w ~/pwd \
    -u $USER \
    -v $PWD:$HOME/pwd \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/.config/gcloud:$HOME/.config/gcloud \
    -p 1080:1080 \
    -e USER=$USER \
    -e USERID=1000 \
    -e GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_APPLICATION_CREDENTIALS \
    $DEV_IMAGE_NAME:latest