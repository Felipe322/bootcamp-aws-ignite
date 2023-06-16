import threading
import psycopg2

# Database connection configuration
db_host = 'bootcamp-cluster-db.cluster-ro-cdvoztklxitw.us-east-1.rds.amazonaws.com'
db_port = 3306
db_name = 'bootcamp-cluster-db'
db_user = 'bootcamp'
db_password = 'your_pass'

# Number of parallel threads
num_threads = 10

# Number of queries to execute per thread
queries_per_thread = 100

#SQL query to stress test the database
#create_db = "CREATE DATABASE bootcamp"
#use_db = "USE bootcamp"
#create_table = "CREATE TABLE bootcamp_tabla (id SERIAL PRIMARY KEY, name VARCHAR(30))"
#test_query = "SELECT * FROM bootcamp_tabla"
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

    if conn.status == psycopg2.extensions.STATUS_READY:
        print("Successfully connected to the database.")

    cursor = conn.cursor()
 #   cursor.execute(create_db)
 #   cursor.execute(use_db)
 #   cursor.execute(create_table)
 #   cursor.execute(test_query_insert)

    for _ in range(queries_per_thread):
        cursor.execute(test_query_insert)
        result = cursor.fetchall()
        query_results.extend(result)

    cursor.close()
    conn.close()

# Create and start the threads
threads = []
for _ in range(num_threads):
    thread = threading.Thread(target=execute_queries)
    threads.append(thread)
    thread.start()

# Wait for all threads to finish
for thread in threads:
    thread.join()

# Print the query results
print(query_results)
