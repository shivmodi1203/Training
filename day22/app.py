from flask import Flask, request
from prometheus_client import Counter, Summary, start_http_server, generate_latest
from prometheus_client.core import CollectorRegistry

# Create a Flask app
app = Flask(__name__)

# Create a Prometheus registry
registry = CollectorRegistry()

# Create metrics to track
REQUEST_COUNT = Counter('http_requests_total', 'Total HTTP Requests', ['method', 'endpoint'], registry=registry)
REQUEST_LATENCY = Summary('http_request_latency_seconds', 'Latency of HTTP requests in seconds', registry=registry)

@app.route('/')
def index():
    REQUEST_COUNT.labels(method=request.method, endpoint='/').inc()  # Increment the counter for this endpoint
    with REQUEST_LATENCY.time():  # Measure the latency for this request
        return "Hello, World!"

@app.route('/metrics')
def metrics():
    # Return the metrics as a Prometheus-compatible text response
    return generate_latest(registry)

if __name__ == '__main__':
    # Start the Prometheus metrics server on port 8000
    start_http_server(8000, registry=registry)
    app.run(port=5000)
