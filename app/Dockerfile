FROM alpine
RUN apk add --no-cache nodejs
ADD index.js /app/index.js
WORKDIR /app
EXPOSE 3000
CMD node index.js

