import socket
import os
import random
import time

PORT = 5000
ADDR = ('localhost', PORT)
FORMAT = "utf-8"

def main(archivo,url,SIZE):
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    client.connect(ADDR)

    file = open(url, "r")
    data = file.read()

    client.send(archivo.encode(FORMAT))
    msg = client.recv(SIZE).decode(FORMAT)
    print(f"[SERVER]: {msg}")

    client.send(data.encode(FORMAT))
    msg = client.recv(SIZE).decode(FORMAT)
    print(f"[SERVER]: {msg}")

    file.close()

    client.close()

def getDirection():
    url=r"/home/pablo/Documentos/pruebas/"
    archivos=os.listdir(url)
    ran=random.randint(0,len(archivos)-1)
    SIZE = os.path.getsize(r"/home/pablo/Documentos/pruebas/"+archivos[ran])
    url=url+archivos[ran]
    return archivos[ran],url,SIZE


if __name__ == "__main__":
    while(True):
        archivo,url,size=getDirection()
        main(archivo,url,size)
        time.sleep(3)
