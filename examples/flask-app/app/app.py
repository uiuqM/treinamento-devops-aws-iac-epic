# app.py — Projeto 2: App Flask em EC2 provisionada com Terraform
from flask import Flask, render_template
import os
import socket

app = Flask(__name__)

app_env   = os.environ.get('APP_ENV', 'desenvolvimento')
app_color = os.environ.get('APP_COLOR', '#232f3e')

@app.route('/')
def home():
    hostname = socket.gethostname()
    return render_template('index.html',
                           env=app_env,
                           color=app_color,
                           hostname=hostname)

@app.route('/health')
def health():
    return {'status': 'ok', 'env': app_env}, 200

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
