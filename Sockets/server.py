import socket

IP = socket.gethostbyname(socket.gethostname())
PORT = 5000
ADDR = ('localhost', PORT)
SIZE = 80000
FORMAT = "utf-8"

def main():
    print("[STARTING] Server is starting.")
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    server.bind(ADDR)

    server.listen()
    print("[LISTENING] Server is listening.")

    while True:
        conn, addr = server.accept()
        print(f"[NEW CONNECTION] {addr} connected.")

        filename = conn.recv(SIZE).decode(FORMAT)
        print(f"[RECV] Receiving the filename.")
        print("Se recibio el archivo "+filename)
        print("Se Guardo el archivo "+filename)
        file = open(r'/home/pablo/Documentos/Traffic/'+filename, "w")
        conn.send("Filename received.".encode(FORMAT))

        data = conn.recv(SIZE).decode(FORMAT)

        print(f"[RECV] Receiving the file data.")
        file.write(data)
        conn.send("File data received".encode(FORMAT))

        file.close()

        conn.close()
        print(f"[DISCONNECTED] {addr} disconnected.\n\n\n")

if __name__ == "__main__":
    main()
