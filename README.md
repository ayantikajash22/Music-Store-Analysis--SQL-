# SQL Project – Music Store Data Analysis

This project performs data analysis on a music store dataset using SQL. The analysis is divided into three sets of questions based on difficulty: Easy, Moderate, and Advanced. The goal is to explore customer behavior, employee details, sales trends, and music preferences.

---

## **Dataset**

The dataset contains the following tables:

- `album` – Contains album information.
- `artist` – Contains artist information.
- `customer` – Contains customer details.
- `employee` – Contains employee details.
- `genre` – Contains music genre details.
- `invoice` – Contains invoice details.
- `invoice_line` – Contains invoice line items.
- `media_type` – Contains media type information.
- `playlist` – Contains playlist information.
- `playlist_track` – Tracks associated with playlists.
- `track` – Contains track details.

---

## **Question Set 1 – Easy**

1. **Senior-most employee**  
   Identify the senior-most employee based on job title. Return their name and job title.

2. **Countries with most invoices**  
   Determine which countries have the highest number of invoices. Return the country name and invoice count.

3. **Top 3 invoice totals**  
   Find the top 3 invoice totals across all customers. Return the customer name, invoice ID, and total amount.

4. **City with highest revenue**  
   Determine the city with the highest revenue for hosting a promotional Music Festival. Return the city name and sum of all invoice totals.

5. **Best customer**  
   Identify the customer who spent the most money. Return the customer’s name and total amount spent.

---

## **Question Set 2 – Moderate**

1. **Rock music listeners**  
   Return the email, first name, last name, and genre of all customers who listen to Rock music. Order results alphabetically by email starting with "A".

2. **Top Rock artists**  
   Identify artists who have written the most Rock music tracks. Return the artist name and total track count for the top 10 Rock artists.

3. **Longest tracks**  
   Return tracks longer than the average song length. Include the track name and duration (in milliseconds), ordered from longest to shortest.

---

## **Question Set 3 – Advanced**

1. **Customer spending by artist**  
   Determine how much each customer spent on each artist. Return the customer name, artist name, and total spent.

2. **Most popular genre by country**  
   Find the most popular music genre for each country (genre with the highest total purchases). Include all genres in case of ties. Return country and genre.

3. **Top-spending customer by country**  
   Identify the customer who has spent the most in each country. Include all customers in case of ties. Return country, customer name, and total spent.

---

## **SQL Exploration**

Example queries for exploring the dataset:

```sql
SELECT * FROM album;
SELECT * FROM artist;
SELECT * FROM customer;
SELECT * FROM employee;
SELECT * FROM invoice;
SELECT * FROM invoice_line;
SELECT * FROM genre;
SELECT * FROM media_type;
SELECT * FROM track;
SELECT * FROM playlist;
SELECT * FROM playlist_track;


---

## Technology Stack
- **Database**: PostgreSQL
- **SQL Queries**: Aggregations, Joins, Subqueries, CTE
- **Tools**: pgAdmin 4 (or any SQL editor), PostgreSQL (via Homebrew, Docker, or direct installation)
