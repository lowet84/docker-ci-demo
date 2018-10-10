FROM alpine
RUN apk add --no-cache nodejs
ADD sever.js /app/server.js
ADD index.html /app/index.html
WORKDIR /app
EXPOSE 3000
CMD node server.js

