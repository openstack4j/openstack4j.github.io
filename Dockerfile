FROM ruby

ENV NGINX_VERSION 1.9.15-1~jessie

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
	&& echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y \
						ca-certificates \
						nginx=${NGINX_VERSION} \
						nginx-module-xslt \
						nginx-module-geoip \
						nginx-module-image-filter \
						gettext-base \
	&& rm -rf /var/lib/apt/lists/* \
        && echo "source 'https://rubygems.org'\ngem 'github-pages'\n" > Gemfile \
        && gem install bundler \
        && bundle install
	
EXPOSE 4000

COPY . /src
COPY support/ /
WORKDIR /src
RUN cd /src  && jekyll build

CMD ["nginx", "-g", "daemon off;"]
