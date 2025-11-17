select*from album;
select*from employee;
select*from customer;
select*from invoice;
select*from Invoice_Line;
select*from genre;
select*from media_type;
select*from track;
select*from playlist_track;
select*from playlist;
select*from artist;
/*	Question Set 1 - Easy */
/* Q1: Who is the senior most employee based on job title? */

select first_name,last_name,title from employee order by title desc limit 1; 

/* Q2: Which countries have the most Invoices? */

select count(billing_country) as c,billing_country from invoice group by billing_country
order by c desc ;

/* Q3: What are top 3 values of total invoice? */

select total from invoice order by total desc limit 3; /* or */
select distinct total from invoice order by total desc limit 3; 

/* Q4: Which city has the best customers? 
We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

    select billing_city,
           sum(total) as total_invoice_amount
    from invoice
    group by billing_city
    order by total_invoice_amount desc limit 1;
)

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/
select 
    c.first_name,
    c.last_name,
    sum(i.total) as total_spent
from customer as c
join invoice as i
    on c.customer_id = i.customer_id
group by c.customer_id
order by total_spent desc
limit 1;
/* Question Set 2 - Moderate */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */


select distinct customer.first_name,customer.last_name,customer.email,genre.name 
from customer join invoice on customer.customer_id=invoice.customer_id join invoice_line on 
invoice.invoice_id=invoice_line.invoice_id join track on invoice_line.track_id= track.track_id join genre on track.genre_id=genre.genre_id 
 where genre.name='Rock' order by customer.email ;
 
/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */


select artist.name, count (track.track_id) as c from artist join album on artist.artist_id=album.artist_id join track 
on album.album_id=track.album_id join genre on track.genre_id=genre.genre_id where genre.name='Rock' 
group by artist.name
order by c desc limit 10;



/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

with a as ( select avg(milliseconds) as avg_song_length
from track)
select t.name ,t.milliseconds
from track as t cross join a where t.milliseconds > a.avg_song_length order by milliseconds desc;

/* Question Set 3 - Advance */

/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    a.name AS artist_name,
    SUM(il.unit_price * il.quantity) AS total_spent
FROM artist AS a
JOIN album AS al ON a.artist_id = al.artist_id
JOIN track AS t ON al.album_id = t.album_id
JOIN invoice_line AS il ON t.track_id = il.track_id
JOIN invoice AS i ON il.invoice_id = i.invoice_id
JOIN customer AS c ON i.customer_id = c.customer_id
GROUP BY c.customer_id, a.artist_id
ORDER BY total_spent DESC;


/* OR (with cte) */

With CTE AS (SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    a.name AS artist_name,
    SUM(il.unit_price * il.quantity) AS total_spent
FROM artist AS a
JOIN album AS al ON a.artist_id = al.artist_id
JOIN track AS t ON al.album_id = t.album_id
JOIN invoice_line AS il ON t.track_id = il.track_id
JOIN invoice AS i ON il.invoice_id = i.invoice_id
JOIN customer AS c ON i.customer_id = c.customer_id
GROUP BY c.customer_id, a.artist_id
ORDER BY total_spent DESC)

SELECT * FROM cte ORDER BY total_spent DESC;



/* Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */


with genre_sales as (
    select 
        i.billing_country as country,
        g.name as genre_name,
        sum(il.unit_price * il.quantity) as total_purchases
    from invoice as i
    join invoice_line as il on i.invoice_id = il.invoice_id
    join track as t on il.track_id = t.track_id
    join genre as g on t.genre_id = g.genre_id
    group by i.billing_country, g.name
)
select country, genre_name, total_purchases
from genre_sales gs
where total_purchases = (
    select max(gs2.total_purchases)
    from genre_sales gs2
    where gs2.country = gs.country
)
order by country;



/* Q3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

WITH customer_purchase AS (
    SELECT 
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        i.billing_country AS country,
        SUM(il.unit_price * il.quantity) AS total_spent
    FROM customer AS c
    JOIN invoice AS i ON c.customer_id = i.customer_id
    JOIN invoice_line AS il ON i.invoice_id = il.invoice_id
    JOIN track AS t ON il.track_id = t.track_id
    JOIN genre AS g ON t.genre_id = g.genre_id
    GROUP BY i.billing_country, customer_name
)

SELECT 
    customer_name,
    country,
    total_spent
FROM customer_purchase AS cp2
WHERE total_spent = (
    SELECT MAX(cp.total_spent)
    FROM customer_purchase AS cp
    WHERE cp.country = cp2.country
)
ORDER BY country;

