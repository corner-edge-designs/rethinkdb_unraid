FROM debian:jessie

MAINTAINER Daniel Alan Miller <dalanmiller@rethinkdb.com>

# Add the RethinkDB repository and public key
# "RethinkDB Packaging <packaging@rethinkdb.com>" http://download.rethinkdb.com/apt/pubkey.gpg
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 3B87619DF812A63A8C1005C30742918E5C8DA04A
RUN echo "deb http://download.rethinkdb.com/apt jessie main" > /etc/apt/sources.list.d/rethinkdb.list

ENV RETHINKDB_PACKAGE_VERSION 2.3.6~0jessie

RUN apt-get update \
	&& apt-get install -y rethinkdb=$RETHINKDB_PACKAGE_VERSION \
	&& rm -rf /var/lib/apt/lists/*

VOLUME ["/data"]


WORKDIR /data



RUN \
	mkdir -p \
    /configs \
    /data \
    && touch /configs/rethink-config.conf 

CMD ["rethinkdb", "--bind", "all" , "--http-port", "8100" ,"--config-file" , "/configs/rethink-config.conf"]

#   process cluster webui
EXPOSE 32400 32400/udp 28016 29016 8100 
