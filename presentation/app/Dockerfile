FROM alpine
RUN apk add --no-cache nodejs
ADD server.js /app/server.js
ADD client.html /app/client.html
WORKDIR /app
EXPOSE 3000
CMD node server.js

