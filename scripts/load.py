# coding=utf-8

# -credits to UNITAS
import os
from pathlib import Path
import ebookmeta #0.11.2
import requests
import pprint
import json
import zipfile
import xml.etree.ElementTree as ET
from unidecode import unidecode

directory = 'ajouter'
URL = "http://localhost:3000"

for filename in os.listdir(directory):
    f = os.path.join(directory, filename)
    # checking if it is a file
    if os.path.isfile(f):
        try:
            if f != unidecode(f):
                print('problema unicode, rinomino il file: '+f)
                filename = unidecode(f)
                os.rename(f, filename)
                f = os.path.join(directory, filename)

            path = Path(f)
            
            parentpath = path.parent.absolute()
            filename = os.path.basename(f)

            #METADATA
            metadata = ebookmeta.get_metadata(f) 
            print(metadata.title)
            print('***METADATA')
            print(metadata.identifier)

            headers = {"Content-Type": "application/json", "Accept": "application/json"}
            payload = {'category_id':1,'daisy_format_id':2,'title':metadata.title}
            r = requests.post(URL+'/contents', data=json.dumps(payload), headers=headers)
            print(r) # 200
            pprint.pprint(r.json())
            # qui è importante la risposta perchè mi da l'id del libro da usare per aggiungere il file
            data = r.json()
            content_id_number = data['id']
            #content_id_number=8
            print('NUOVO ID: ' + str(content_id_number))

            payload = {'content_id':content_id_number,'key':'dc:title','value':metadata.title} 
            r = requests.post(URL+'/content_metadata', data=json.dumps(payload), headers=headers)

            payload = {'content_id':content_id_number,'key':'dc:creator','value':metadata.get_author_string()} 
            print('Autors: '+ metadata.get_author_string())
            r = requests.post(URL+'/content_metadata', data=json.dumps(payload), headers=headers)
            print(r) # 201
            pprint.pprint(r.json())

            # payload = {'content_id':content_id_number,'key':'dc:format','value':metadata.format}
            # print('Format: '+metadata.format)
            # r = requests.post(URL+'/content_metadata', data=json.dumps(payload), headers=headers)
            # print(r)

            #payload = {'content_id':content_id_number,'key':'dc:date','value':metadata.date}
            #r = requests.post(URL+'/content_metadata', data=json.dumps(payload), headers=headers)
            #print(r)   

            payload = {'content_id':content_id_number,'key':'dc:identifier','value':metadata.identifier}
            print('identifier: '+metadata.identifier)
            r = requests.post(URL+'/content_metadata', data=json.dumps(payload), headers=headers)
            print(r) 

            payload = {'content_id':content_id_number,'key':'dc:language','value':metadata.lang}
            print('lang: '+metadata.lang)
            r = requests.post(URL+'/content_metadata', data=json.dumps(payload), headers=headers)
            print(r) 

            
            descriptionEditata= metadata.description
            descriptionEditata= descriptionEditata.replace("&lt;div&gt;", "")
            descriptionEditata= descriptionEditata.replace("&lt;p&gt;", "")
            descriptionEditata= descriptionEditata.replace("&lt;/p&gt;&lt;/div&gt;", "")
            descriptionEditata= descriptionEditata.replace("<div>", "")
            descriptionEditata= descriptionEditata.replace("<p>", "")
            descriptionEditata= descriptionEditata.replace("</div>", "")
            descriptionEditata= descriptionEditata.replace("</p>", "")
            descriptionEditata = 'TRAMA: '+descriptionEditata
            payload = {'content_id':content_id_number,'key':'dc:description','value':descriptionEditata}
            print('description: '+descriptionEditata)
            r = requests.post(URL+'/content_metadata', data=json.dumps(payload), headers=headers)
            print(r) 

            # payload = {'content_id':content_id_number,'key':'dc:publisher','value':'Unitas' }
            # print('publisher: '+'Unitas' )
            # r = requests.post(URL+'/content_metadata', data=json.dumps(payload), headers=headers)
            # print(r)  
            # if metadata.cover_file_name != None:
            #     print(metadata.cover_file_name)
            #     print(metadata.cover_media_type)
            #     if metadata.cover_media_type == 'image/jpeg':  
            #         estensione = 'jpg'
            #     else:   
            #         estensione = 'png'
            #     print('estensione: ' + estensione)
            #     with open('//10.1.10.26/o/cover/' + str(content_id_number) + '.' + estensione, "wb") as binary_file:
            #         binary_file.write(metadata.cover_image_data)
            #     payload = {'content_id':content_id_number,'key':'cover', 'value':'https://opac.unitas.ch/cover/'+ str(content_id_number) + '.' +estensione}
            #     r = requests.post(URL+'/content_metadata', data=json.dumps(payload), headers=headers)
            #     print(r) 
      
            #payload = {'content_id':content_id_number,'key':'meta name="pippo" content="filippo"','value':null}
            #r = requests.post(URL+'/content_metadata', data=json.dumps(payload), headers=headers)
            #print(r) 


            #Leggo il campo age che ho agginto nel mio calibre, ed editato manualmente nei vari epub
            archive = zipfile.ZipFile(f, 'r')
            
            opf = archive.read('EPUB/package.opf')
            root  = ET.fromstring(opf)
            

            for mymeta in root.findall("./{http://www.idpf.org/2007/opf}metadata/{http://www.idpf.org/2007/opf}meta[@property='calibre:user_metadata']"):
                myjson = mymeta.text
            if 'myjson' in locals():
                stanley = json.loads(myjson)

                i = stanley['#age']['#value#']
                payload = {'content_id':content_id_number,'key':'age', 'value':str(i)}
                r = requests.post(URL+'/content_metadata', data=json.dumps(payload), headers=headers)
                print("età: "+str(i)) 

            print('***FILE EPUB')

            headers = {'Accept': 'application/json'}
            files = {'resource':open(f, 'rb')}
            data = {
                'mime_type':'application/epub+zip', 
                'bytes':os.path.getsize(f),
                'file_name':filename
            }

            r = requests.post(URL+'/contents/'+str(content_id_number)+'/resource', files=files, data=data, headers=headers) 
            print(r) 

            print('***ADD TO USERS')
            headers = {"Content-Type": "application/json", "Accept": "application/json"}
            payload = {'content_id':content_id_number}
            r = requests.post(URL+'/user_contents/add', data=json.dumps(payload), headers=headers)
            print(r) 

            payload = {'content_id':content_id_number, 'users':[1,2,3,4,5,6]}
            r = requests.post(URL+'/user_contents/add', data=json.dumps(payload), headers=headers)
            print(r) 
        except Exception as e:
            print("ERRORE CON LIBRO: " + str(e))
