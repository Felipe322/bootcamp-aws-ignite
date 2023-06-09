const http = require('http')
const port = 80

const server = http.createServer(function (req, res) {
	res.write('Bootcamp AWS Ignite 2023 Nodejs!')
	res.end()
})

server.listen(port, function (error) {
	if (error) {
		console.log('Ocurrio un error: ', error);
	}
	else {
		console.log('Escuchando por el puerto: ' + port);
	}
})