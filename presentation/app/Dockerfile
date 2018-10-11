FROM alpine
RUN apk add --no-cache nodejs
ADD server.js /app/server.js
ADD index.html /app/index.html
WORKDIR /app
EXPOSE 3000
CMD node server.js

