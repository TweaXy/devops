#!/bin/bash
aws ssm put-parameter --name "frontend_image_version" --value "$FRONTEND_IMG_VERSION" --type "String" --overwrite
ssh -i /opt/frontcrss $frontend_dev_user@$frontend_dev_server "mkdir -p /home/omarsaid/frontend"
scp -i /opt/frontcrss  docker-compose.yml $frontend_dev_user@$frontend_dev_server:/home/omarsaid/frontend/docker-compose.yml
scp -i /opt/frontcrss  frontend.sh $frontend_dev_user@$frontend_dev_server:/home/omarsaid/frontend/frontend.sh
ssh -i /opt/frontcrss $frontend_dev_user@$frontend_dev_server "cd /home/omarsaid/frontend && chmod +x frontend.sh && ./frontend.sh"