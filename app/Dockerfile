FROM alpine
RUN apk add --no-cache nodejs
ADD index.js /app/index.js
ADD index.html /app/index.html
WORKDIR /app
EXPOSE 3000
CMD node index.js

