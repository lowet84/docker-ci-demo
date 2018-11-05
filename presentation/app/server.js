// content of server.js
const http = require('http')
const fs = require('fs')
const port = 3000

const requestHandler = (request, response) => {
  if(request.url==='/data'){
    response.end('Some text')
    // response.end('Noll till CD på 708s<br><h6>(demoapp.fredriklowenhamn.com)</h6>')
    // response.end('708 sekunder tidigare...')
  }

  var file =  fs.readFileSync('client.html', 'utf8');
  response.end(file)
}

const server = http.createServer(requestHandler)

server.listen(port, (err) => {
  if (err) {
    console.log('something bad happened', err)
  }

  console.log(`server is listening on ${port}`)
})
