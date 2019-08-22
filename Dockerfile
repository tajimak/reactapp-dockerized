ARG NODE_TAG=12
FROM node:${NODE_TAG}
ARG NODE_TAG
ARG APP_HOME=/home/node/app

RUN echo "node:${NODE_TAG}" > /docker-image-tag && cat /docker-image-tag && \
    mkdir $APP_HOME && chown node:node $APP_HOME

USER node
WORKDIR $APP_HOME
COPY --chown=node:node package*.json $APP_HOME/
RUN npm install --production && npm cache clean --force

COPY --chown=node:node src $APP_HOME/src/
COPY --chown=node:node public $APP_HOME/public/

CMD ["/bin/bash","-c","npm start"]
