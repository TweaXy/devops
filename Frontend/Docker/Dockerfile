FROM node:21-bookworm-slim as base
SHELL ["/bin/bash", "-c"]
RUN apt update
WORKDIR /app/frontend
COPY . .
#EXPOSE 5173
RUN npm update
RUN npm install
RUN npm test
#CMD npm run dev
RUN npm run build
FROM nginx
EXPOSE 80
EXPOSE 443
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY --from=base /app/frontend/dist /usr/share/nginx/html 
WORKDIR /etc/nginx/dhparam
RUN openssl dhparam -out dhparam-2048.pem 2048
 