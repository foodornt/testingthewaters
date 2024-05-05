from flask import Flask, request, jsonify
import numpy as np
import cv2
import tensorflow as tf
import mediapipe as mp
import joblib
import base64
import firebase_admin
from firebase_admin import credentials
import logging

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)

# Initialize Firebase Admin
cred_path = r"C:\Users\huawei\Downloads\beyan_a (2)\beyan_a\fluttertest-91869-firebase-adminsdk-dzz3u-645182b763.json"
cred = credentials.Certificate(cred_path)
firebase_admin.initialize_app(cred)

class SignLanguageTranslator:
    def __init__(self):
        self.model_path = r'C:\Users\huawei\OneDrive\Desktop\sign-to-text\models\model.tflite'
        self.label_encoder_path = r'C:\Users\huawei\OneDrive\Desktop\sign-to-text\outputs\label_encoder.pkl'
        self.load_resources()

    def load_resources(self):
        self.interpreter = tf.lite.Interpreter(model_path=self.model_path)
        self.interpreter.allocate_tensors()
        self.label_encoder = joblib.load(self.label_encoder_path)
        self.hands = mp.solutions.hands.Hands(min_detection_confidence=0.5, min_tracking_confidence=0.5)

    def process_frame(self, image_data):
        try:
            print("Just received an image!")
            print("Length of image data: ", len(image_data))
            print("First 100 bytes: ", image_data[:300])
            # Store image data in a file
            with open('frame.txt', 'w') as f:
                f.write(image_data)

            image = np.frombuffer(base64.b64decode(image_data), dtype=np.uint8)
            print("Length of image: ", len(image))
            frame = cv2.imdecode(image, cv2.IMREAD_COLOR)
            print("Length of frame: ", len(frame))
            cv2.imwrite('frame.jpg',frame)
            if frame is None:
                logging.error("Failed to decode image.")
                return {'gesture': 'Error in decoding image'}
            rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            results = self.hands.process(rgb_frame)
            if results.multi_hand_landmarks:
                # Just use the first detected hand for prediction
                landmarks = np.array([[lm.x, lm.y, lm.z] for lm in results.multi_hand_landmarks[0].landmark]).flatten().astype(np.float32)
                gesture_label = self.predict(landmarks)
                return {'gesture': gesture_label}
            else:
                return {'gesture': 'No hands detected'}
        except Exception as e:
            logging.error(f"Error processing frame: {str(e)}")
            return {'gesture': 'Error in processing super sad :(/'}

    def predict(self, landmarks):
        try:
            self.interpreter.set_tensor(self.interpreter.get_input_details()[0]['index'], [landmarks])
            self.interpreter.invoke()
            output_data = self.interpreter.get_tensor(self.interpreter.get_output_details()[0]['index'])
            prediction = np.argmax(output_data)
            predicted_label = self.label_encoder.inverse_transform([prediction])[0]
            return predicted_label
        except Exception as e:
            logging.error(f"Error during model prediction: {e}")
            return "Prediction Error"

translator = SignLanguageTranslator()

@app.route('/', methods=['GET'])
def index():
    return jsonify({'message': 'Hello World!'})

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    image_data = data.get('image')
    print("Just received an image!")
    if not image_data:
        print("No image provided")
        return jsonify({'error': 'No image provided'}), 400
    result = translator.process_frame(image_data)
    return jsonify(result)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
