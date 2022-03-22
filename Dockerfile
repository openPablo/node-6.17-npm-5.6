FROM node:6.17.1
RUN npm i -g npm3 && \
    npm3 -g uninstall npm && \
    npm3 i -g npm@5.6.0 && \
    npm -g uninstall npm3 && \
    npm cache clean --force

#hack to make COPY work in bitbucketpipelines:
RUN  chown root:root -R /usr/local/lib/node_modules/

FROM node:6.17.1-alpine
WORKDIR /home/node
COPY --from=0 /usr/local/lib/node_modules/npm/ /usr/local/lib/node_modules/npm/
CMD /bin/sh