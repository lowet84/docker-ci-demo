// content of index.js
const http = require('http')
const fs = require('fs')
const port = 3000

const requestHandler = (request, response) => {
  if(request.url==='/data'){
    response.end('Some text')
  }

  var file =  fs.readFileSync('index.html', 'utf8');
  response.end(file)
}

const server = http.createServer(requestHandler)

server.listen(port, (err) => {
  if (err) {
    console.log('something bad happened', err)
  }

  console.log(`server is listening on ${port}`)
})
