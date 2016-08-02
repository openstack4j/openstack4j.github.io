# OpenStack4j's Website

This is the source to OpenStack4j.com.   We use Jekyll to generate the static content for this site.  

### Pre-requisites

```
gem install jekyll
```

### Run

```
jekyll serve -w
```

Browse on `http://localhost:4000`

### Run with Docker

```
docker build --tag os4jdoc . && docker run --name os4jdoc -d -p 4000:4000 -p 80:80 os4jdoc
```

### Contribute

Have documentation you would like to contribute to the OpenStack4j site.   Fork this repo, update the docs and submit a pull request for review
