from http.server import HTTPServer, BaseHTTPRequestHandler

class HelloWorldHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b'Bootcamp AWS Ignite 2023 Python!')

def run_server():
    server_address = ('', 80)
    httpd = HTTPServer(server_address, HelloWorldHandler)
    print('Server running on port 80')
    httpd.serve_forever()

if __name__ == '__main__':
    run_server()