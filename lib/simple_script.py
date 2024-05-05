import requests
import json
# Base64
import base64
#image_to_predict = "https://t4.ftcdn.net/jpg/02/90/23/21/360_F_290232144_RC61HlvYRQQGin1WJeFkzfs1B7fgn2k5.jpg"
# image_to_predict = "https://t4.ftcdn.net/jpg/00/48/06/79/360_F_48067989_5Pr5M50N4AdKp3MwdJ59pR89Y98TGaQB.jpg"
image_to_predict = "https://media.kenanaonline.com/photos/1173777/1173777835/large_1173777835.jpg"

# Download the image and convert it to base64

image_to_predict = base64.b64encode(requests.get(image_to_predict).content).decode('utf-8')

headers = {
    'Content-Type': 'application/json'
}

data = {
    'image': image_to_predict
}

# No retries
response_without_retry = requests.post('http://127.0.0.1:5000/predict', headers=headers, data=json.dumps(data), timeout=1)

if __name__ == '__main__':
    print(response_without_retry.json())
    
exit()

print(response.json())