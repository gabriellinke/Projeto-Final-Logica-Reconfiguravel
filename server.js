const net = require("net");
const server = net.createServer(socket => {
    console.log("connected");
// -------------------------------------|EN|PR| TIMER  |  DUTY  |
//					       0000000000000|1 |00|00001111|00000000|	-> 3840
//    PADRãO DE MSG ->     0000000000000|1 |00|00011001|00000000|
//						   0000000000000|1 |00|00001111|00001111|	-> 3855

    socket.write("1000000111100000111"); //VALORES INICIAIS

    setTimeout(() => {
        socket.write("1000001111100000101");
    }, 1 * 1000);

    setTimeout(() => {
        socket.write("1000010111100000011");
    }, 1 * 2000);

    setTimeout(() => {
        socket.write("1000000111100000100");
    }, 1 * 3000);

    setTimeout(() => {
        socket.write("10100011111100001111");
    }, 1 * 4000);

    socket.on("data", data => {
        console.log("[DATA]", data.toString());
    });

    socket.on("end", () => {
        console.log("connection ended");
    });
});

server.listen(5000);