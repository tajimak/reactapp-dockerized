ARG NODE_TAG=12
ARG NGINX_TAG=alpine
ARG APP_HOME=/home/node

# build stage
FROM node:${NODE_TAG} as build
ARG NODE_TAG
ARG APP_HOME

WORKDIR ${APP_HOME}
COPY --chown=node:node package*.json ${APP_HOME}/
RUN npm install --production 

COPY --chown=node:node src ${APP_HOME}/src/
COPY --chown=node:node public ${APP_HOME}/public/
RUN npm run build

# deploy stage
FROM nginx:${NGINX_TAG}
ARG NGINX_TAG
ARG APP_HOME
RUN echo "nginx:${NGINX_TAG}" > /docker-image-tag && cat /docker-image-tag
COPY --from=build ${APP_HOME}/build /usr/share/nginx/html

WORKDIR /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
