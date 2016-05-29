FROM containx/jekyll-nginx

COPY . /src
COPY support/ /
WORKDIR /src
RUN cd /src  && jekyll build

