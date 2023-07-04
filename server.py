#!/usr/bin/env python3
import asyncio
import signal
from time import sleep
signal.signal(signal.SIGINT, signal.SIG_DFL)
host = "192.168.15.15"
port = 5000
f = open("input.dat", "r")

async def handle_data(reader, writer):
    addr = writer.get_extra_info('peername')
    print(f"Connected to {addr!r}")

    for line in f:
        message = (line.strip() + "\n").encode()
        # message = next(f).strip() + "\n"
        print(f"Send: {message!r}")
        writer.write(message)
        await writer.drain()
        data = await reader.readline()
        messageRec = data.decode()
        output = int(messageRec)
        print(f"Received {output} from {addr!r}")

    while True:
        data = await reader.readline()
        messageRec = data.decode()
        output = int(messageRec)
        print(f"Received {output} from {addr!r}")


    # print("Close the connection")
    # writer.close()
    # await writer.wait_closed()

async def main():
    server = await asyncio.start_server(
        handle_data, host, port)

    addrs = ', '.join(str(sock.getsockname()) for sock in server.sockets)
    print(f'Serving on {addrs}')

    async with server:
        await server.serve_forever()
# def server():
#     server_socket = socket.socket()  # get instance
#     # look closely. The bind() function takes tuple as argument
#     server_socket.bind((host, port))  # bind host address and port together
#     server_socket.settimeout(2)

#     # configure how many client the server can listen simultaneously
#     print("Listening on " + str(host) + " port " + str(port))
#     server_socket.listen(1)
#     conn, address = server_socket.accept()  # accept new connection
#     print("Connection from: " + str(address))
#     # data = str(1000)
#     # conn.send(data.encode())  # send data to the client
#     while True:
#         data = str(1000) + "\n"
#         conn.send(data.encode())  # send data to the client
#         # receive data stream. it won't accept data packet greater than 1024 bytes
#         try:
#             data = conn.recv(1024)
#         except(socket.timeout, e):
#             err = e.args[0]
#             if err == 'timed out':
#                 sleep(1)
#                 print 'recv timed out, retry later'
#                 continue
#             else:
#                 print e
#                 sys.exit(1)
#         print("from connected user: " + str(data))

#     conn.close()  # close the connection

if __name__ == '__main__':
    asyncio.run(main())
