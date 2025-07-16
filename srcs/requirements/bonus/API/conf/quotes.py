from flask import Flask, jsonify
import random

app = Flask(__name__)

QUOTES = [
    "Life is short, use Docker.",
    "Containers are just fancy chroot.",
    "Keep calm and code in Python.",
    "Don't trust a container you didn't build yourself.",
    "Debugging is like being the detective of a murder where you're also the murderer."
]

@app.route("/api/quote")
def api_quote():
    return jsonify({"quote": random.choice(QUOTES)})

@app.route("/")
def home():
    return """
    <html>
      <head><title>Quote API</title></head>
      <body>
        <h1>Welcome to the Quote API!</h1>
        <p>Try <a href="/api/quote">/api/quote</a> for a random quote in JSON.</p>
      </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
