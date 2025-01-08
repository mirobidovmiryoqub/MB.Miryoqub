import pymysql
from prettytable import PrettyTable

# Database connection details
connection = pymysql.connect(
    host="localhost",
    port=3306,
    user="root",
    passwd="",
    database="alfraganus"
)

try:
    cursor = connection.cursor()

    # Function to fetch data and display as table
    def fetch_and_display(query, table_name):
        cursor.execute(query)
        results = cursor.fetchall()

        if cursor.rowcount > 0:
            # Create a PrettyTable object
            columns = [desc[0] for desc in cursor.description]
            table = PrettyTable(columns)

            for row in results:
                table.add_row(row)

            print(f"Таблица: {table_name}")
            print(table)
        else:
            print(f"Таблица {table_name} пуста.")

    # Queries and table names
    queries = [
        ("SELECT * FROM Yonalish", "Yonalish"),
        ("SELECT * FROM kafedralar", "Kafedralar"),
        ("SELECT * FROM studentlar", "Studentlar"),
    ]

    for query, table_name in queries:
        fetch_and_display(query, table_name)

    # Example of inserting a new record into the table
    # insert_query = "INSERT INTO sample_table (column1, column2) VALUES (%s, %s)"
    # cursor.execute(insert_query, ("value1", "value2"))

    # Commit changes to the database
    connection.commit()

except pymysql.MySQLError as e:
    print(f"Error: {e}")
finally:
    # Closing the connection
    connection.close()
