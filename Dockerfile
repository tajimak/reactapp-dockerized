ARG TAG=latest
FROM node:${TAG}
ARG TAG
ARG APP_HOME=/home/node/app

RUN echo "node:${TAG}" > /docker-image-tag && cat /docker-image-tag && \
    mkdir $APP_HOME && chown node:node $APP_HOME
    # npm install --global serve && npm cache clean --force

USER node
WORKDIR $APP_HOME
COPY --chown=node:node package*.json $APP_HOME/
RUN npm install --production && npm cache clean --force

COPY --chown=node:node src $APP_HOME/src/
COPY --chown=node:node public $APP_HOME/public/
# RUN npm run build

CMD ["/bin/bash","-c","npm start"]
# CMD ["/bin/bash","-c","serve -s build"]
