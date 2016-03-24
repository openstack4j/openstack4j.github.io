#!/bin/bash

set -ex

cd /src
jekyll build
nginx -g daemon off
