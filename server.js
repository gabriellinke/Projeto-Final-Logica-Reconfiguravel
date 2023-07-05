const fs = require('fs');
const net = require('net');

const server = net.createServer(socket => {
  console.log('Client connected');

  // Read the file and send its contents line by line
  const fileStream = fs.createReadStream('input.dat', 'utf-8');
  fileStream.on('data', chunk => {
    const lines = chunk.split('\n');
    lines.forEach(line => {
      socket.write(line + '\n');
    });
  });

  const outputFileStream = fs.createWriteStream('out.dat');

  fileStream.on('end', () => {
    console.log('File transmission complete');
    //socket.end(); // Close the connection once file is sent
  });

  socket.on("end", () => {
    console.log("connection ended");
  });

  socket.on('close', () => {
    console.log('Client disconnected');
  });
  
  socket.on("data", data => {
	const receivedData = data.toString();
	outputFileStream.write(receivedData);
	console.log(receivedData);
  });
});

server.listen(5000);
