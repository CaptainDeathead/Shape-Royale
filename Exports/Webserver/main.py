from flask import Flask, send_from_directory
import socket

app = Flask(__name__)

@app.route('/game')
def serve_game():
    return send_from_directory('C:/Users/CaptainDeathead/Documents/GitHub/Shape-Royale/Exports/v1.0.0.0 (web)', 'Shape-royale.html')

@app.route('/game/<path:path>')
def game_files(path):
    return send_from_directory('C:/Users/CaptainDeathead/Documents/GitHub/Shape-Royale/Exports/v1.0.0.0 (web)', path)

@app.route('/Shape-royale.js')
def serve_js():
    return send_from_directory('C:/Users/CaptainDeathead/Documents/GitHub/Shape-Royale/Exports/v1.0.0.0 (web)', 'Shape-royale.js')

@app.route('/Shape-royale.wasm')
def serve_wasm():
    return send_from_directory('C:/Users/CaptainDeathead/Documents/GitHub/Shape-Royale/Exports/v1.0.0.0 (web)', 'Shape-royale.wasm')

@app.route('/Shape-royale.pck')
def serve_pck():
    return send_from_directory('C:/Users/CaptainDeathead/Documents/GitHub/Shape-Royale/Exports/v1.0.0.0 (web)', 'Shape-royale.pck')

#print the ip address of the server
print('Server IP: ' + socket.gethostbyname(socket.gethostname()))

app.run(host='192.168.0.30', port=1341)