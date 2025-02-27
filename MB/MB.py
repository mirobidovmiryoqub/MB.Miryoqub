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





-- 1. Users jadvali
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15),
    Address TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Services jadvali
CREATE TABLE Services (
    ServiceID INT AUTO_INCREMENT PRIMARY KEY,
    ServiceName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Invoices jadvali
CREATE TABLE Invoices (
    InvoiceID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    ServiceID INT NOT NULL,
    InvoiceDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    DueDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    Status ENUM('Paid', 'Unpaid', 'Overdue') DEFAULT 'Unpaid',
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID) ON DELETE CASCADE
);

-- 4. Payments jadvali
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    InvoiceID INT NOT NULL,
    PaymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    AmountPaid DECIMAL(10, 2) NOT NULL,
    PaymentMethod ENUM('Credit Card', 'Bank Transfer', 'Cash') NOT NULL,
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID) ON DELETE CASCADE
);

-- Ma'lumotlarni kiritish

-- Users jadvaliga ma'lumot kiritish
INSERT INTO Users (FullName, Email, PhoneNumber, Address) VALUES
('Ali Valiyev', 'ali.valiyev@example.com', '+998901234567', 'Tashkent, Uzbekistan'),
('Oyxon Ismoilova', 'oyxon.ismoilova@example.com', '+998902345678', 'Samarkand, Uzbekistan'),
('Bekzod Rasulov', 'bekzod.rasulov@example.com', '+998903456789', 'Bukhara, Uzbekistan');

-- Services jadvaliga ma'lumot kiritish
INSERT INTO Services (ServiceName, Description, Price) VALUES
('Internet 100 Mbps', 'High-speed internet connection', 50.00),
('TV Package', 'Premium TV channels', 30.00),
('Home Security', '24/7 home monitoring service', 75.00);

-- Invoices jadvaliga ma'lumot kiritish
INSERT INTO Invoices (UserID, ServiceID, DueDate, TotalAmount, Status) VALUES
(1, 1, '2025-02-01', 50.00, 'Unpaid'),
(2, 2, '2025-02-05', 30.00, 'Unpaid'),
(3, 3, '2025-02-10', 75.00, 'Paid');

-- Payments jadvaliga ma'lumot kiritish
INSERT INTO Payments (InvoiceID, PaymentDate, AmountPaid, PaymentMethod) VALUES
(3, '2025-01-10 10:00:00', 75.00, 'Credit Card');
