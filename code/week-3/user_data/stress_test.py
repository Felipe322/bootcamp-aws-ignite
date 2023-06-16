import psycopg2
import json

from concurrent.futures import ThreadPoolExecutor
from http.server import HTTPServer, BaseHTTPRequestHandler

# Database connection configuration
db_host = 'bootcamp-cluster-db'
db_port = 3306
db_name = 'bootcamp-db'
db_user = 'bootcamp'
db_password = 'your_pass'

# Number of parallel threads
num_threads = 10

# Number of queries to execute per thread
queries_per_thread = 100

# SQL query to stress test the database
create_db = "CREATE DATABASE bootcamp"
use_db = "USE bootcamp"

create_table = "CREATE TABLE bootcamp_tabla (id INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY, name VARCHAR(30))"

# SQL query to stress test the database
test_query = "SELECT * FROM bootcamp_tabla"
test_query_insert = "INSERT INTO bootcamp_tabla (name) VALUES ('Participante')"

# Variable to store the query results
query_results = []

# Function to execute queries
def execute_queries():
    conn = psycopg2.connect(
        host=db_host,
        port=db_port,
        dbname=db_name,
        user=db_user,
        password=db_password
    )
    cursor = conn.cursor()
    cursor.execute(create_db)
    cursor.execute(use_db)
    cursor.execute(create_table)
    cursor.execute(test_query_insert)
   
    for _ in range(queries_per_thread):
        cursor.execute(test_query)
        result = cursor.fetchall()
        query_results.extend(result)
    cursor.close()
    conn.close()

# Create a thread pool
with ThreadPoolExecutor(max_workers=num_threads) as executor:
    # Submit tasks to the thread pool
    futures = [executor.submit(execute_queries) for _ in range(num_threads)]

# HTTP Server
class HelloWorldHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps(query_results).encode())

def run_server():
    server_address = ('', 80)
    httpd = HTTPServer(server_address, HelloWorldHandler)
    print('Server running on port 80')
    httpd.serve_forever()

if __name__ == '__main__':
    run_server()
