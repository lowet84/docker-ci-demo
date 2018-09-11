# Set base image
FROM alpine:latest
MAINTAINER Fredrik Löwenhamn <fredrik.lowenhamn@gmail.com>

# Set variables
ENV REVEALJS_VERSION 3.7.0
ENV REVEALJS_INSTALL_DIR /srv/reveal.js

RUN apk add --no-cache nodejs-npm curl

# Get reveal.js from Github repository
RUN cd /tmp \
    && curl -SLO "https://github.com/hakimel/reveal.js/archive/$REVEALJS_VERSION.tar.gz" \
    && mkdir -p $REVEALJS_INSTALL_DIR \
    && tar -xzf "$REVEALJS_VERSION.tar.gz" -C $REVEALJS_INSTALL_DIR --strip-components=1 \
    && rm "$REVEALJS_VERSION.tar.gz"

# Enter reveal.js directory
WORKDIR $REVEALJS_INSTALL_DIR

# Install reveal.js
RUN npm install

# Remove demo file
RUN rm demo.html

# Expose port 80
EXPOSE 8000

ADD index.html /srv/reveal.js/index.html

# Run npm server
CMD npm start
