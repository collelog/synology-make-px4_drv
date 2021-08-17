FROM ubuntu:18.04
LABEL maintainer "collelog <collelog.cavamin@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux && \
	apt-get update -qq && \
	apt-get install -y -qq --no-install-recommends bash build-essential ca-certificates curl git python3 unzip && \
	\
	# cleaning
	apt-get clean && \
	rm -rf /tmp/* /var/lib/apt/lists/*
