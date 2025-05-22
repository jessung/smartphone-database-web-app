# smartphone-database-web-app
This is a MySQL relational database populated with data about smartphones, with a simple web application for viewing purposes.

Dataset: https://www.kaggle.com/datasets/informrohit1/smartphones-dataset

To set up the database, run the following scripts located in the "scripts" folder in this order:
1. setup-database.sql

This creates the database.
  
2. create-tables.sql

This creates all the necessary tables in the database.

3. load-dnorm-date.sql

This creates the table "denormalised" and inserts all the data from the CSV file as a denormalised dataset.

4. ingest-data.sql

This inserts the data from the denormalised table into the tables created from create-tables.sql

To run the web application in the browser, open the terminal and redirect to the location of the
web-app file.

Next, run the command
````
node app.js
````
The web app can then be viewed by opening the browser preview and entering the URL.

ER model
![ER model](https://github.com/user-attachments/assets/b6b4f3c5-c1ba-42cb-8a25-fe8177b4518b)

ER diagram
![Screenshot 2024-07-05 121809](https://github.com/user-attachments/assets/ab4bd11f-f040-44cd-8c20-8ca59fc9f097)
