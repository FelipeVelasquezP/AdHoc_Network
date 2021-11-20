import json
import csv

f = open("traza2.json", "r")
content = f.read()
traza = json.loads(content)

with open('traza.csv', 'w', encoding='UTF8') as f:
    writer = csv.writer(f)
    traza2=traza['intervals']
    for paquete in traza['intervals']:
      paquete=paquete['streams'][0]
      intervaloTiempo=f'{paquete["start"]} -- {paquete["end"]}'
      tiempoArribo=paquete["seconds"]
      tamano=paquete["bytes"]
      anchoBanda=paquete["bits_per_second"]
      rtt=paquete["rtt"]
      paq=[intervaloTiempo,'sec',tiempoArribo,'sec',tamano,'bytes',anchoBanda,'bps',rtt,'sec']
      writer.writerow(paq)