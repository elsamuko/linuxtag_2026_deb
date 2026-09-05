#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write("Hello from Linuxtag with debhelper".encode())


if __name__ == "__main__":
    webServer = HTTPServer(("localhost", 8080), Handler)
    print("Started server http://localhost:8080")

    try:
        webServer.serve_forever()
    except KeyboardInterrupt:
        pass

    webServer.server_close()
    print("\b\bStopped server")
