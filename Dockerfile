FROM ubuntu
USER root
RUN mkdir -p /data/kong-dashboard &&  \
    apt-get update && apt-get install -y git curl && \
    curl -sL https://deb.nodesource.com/setup_6.x > /tmp/nodejs.sh && \
    bash /tmp/nodejs.sh && \
    apt-get install -y nodejs && \
    npm install bower -g && \
    npm install -g bower

#USER kong

COPY .bowerrc /data
COPY bower.json /data
COPY material-icons.patch /data

RUN cd /data && \
    git clone https://github.com/PGBI/kong-dashboard/ /data/kong-dashboard && \
    ls -la && \
    bower update --allow-root && \
    patch -p0 <material-icons.patch && \
    cd /data/kong-dashboard && \
    npm install && npm run install

WORKDIR /data/kong-dashboard
EXPOSE 8080
CMD npm run start

