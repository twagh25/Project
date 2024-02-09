use music_data;

-- # Question Set 1 - Easy

-- 1. Who is the senior most employee based on job title?
select * from employee;
select * from employee
order by levels desc
limit  1 ;

-- 2. Which countries have the most Invoices?
select * from Invoice;
select count(invoice_id) as 'Invoice',
       billing_country as 'country'
from Invoice
group by billing_country
order by 'Invoices' desc 
limit 1;

-- 3. What are top 3 values of total invoice?
select total
from Invoice
order by total desc 
limit  3;

/* 4. Which city has the best customers? We would like to throw a promotional Music 
Festival in the city we made the most money. Write a query that returns one city that 
has the highest sum of invoice totals. Return both the city name & sum of all invoice 
totals */

select sum(total) as 'Invoice_Total',
       billing_city as 'city' 
from invoice
group by billing_city
order by 'Invoice_Total' desc
limit 1;

/* 5. Who is the best customer? The customer who has spent the most money will be 
declared the best customer. Write a query that returns the person who has spent the 
most money */

select * from invoice;
select * from customer;
select  c.customer_id,c.first_name,c.last_name,
       sum(i.total) as total
from customer c inner join invoice i on c.customer_id = i.customer_id 
group by c.customer_id,c.first_name,c.last_name
order by total desc
limit 1;


-- # Question Set 2 – Moderate


/*1. Write query to return the email, first name, last name, & Genre of all Rock Music 
listeners. Return your list ordered alphabetically by email starting with A          */
select * from customer;
select distinct email ,first_name,last_name
from customer c 
join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
where track_id in (select track_id from track t
                   join genre g on t.genre_id = g.genre_id
                   where g.name like 'rock')
order by email ;

select distinct email ,first_name,last_name,g.name
from customer c 
join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
join track t on  il.track_id = t.track_id
join genre g on t.genre_id = g.genre_id
where g.name like 'rock'
order by email ;

/* 2. Let's invite the artists who have written the most rock music in our dataset. Write a 
query that returns the Artist name and total track count of the top 10 rock bands                */
select * from artist;
select * from track;
select a.artist_id,
       a.name,
       count(a.artist_id) as number_of_songs
from artist a 
join album2 al on a.artist_id = al.artist_id 
join track t on al.album_id = t.album_id
join genre g on t.genre_id = g.genre_id
where g.name like 'rock' 
group by a.artist_id,a.name
order by number_of_songs desc
limit 10;

/* 3. Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the 
longest songs listed first    */

select * from track;
select name,
       milliseconds
from track
where milliseconds > (select avg(milliseconds) as avg_millisecond from track)
order by milliseconds desc ;


-- # Question Set 3 – Advance
-- 1. Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent
with best_selling_artist as (select a.artist_id,a.name as artist_name ,sum(il.unit_price*il.quantity) as total_sales
from artist a
join album2 alb on a.artist_id = alb.artist_id
join track t on alb.album_id = t.album_id
join invoice_line il on t.track_id = il.track_id
group by a.artist_id ,artist_name
ORDER BY total_sales DESC
)
SELECT concat(c.first_name,' ',c.last_name) as customer_name,bsa.artist_id,bsa.artist_name,
sum(il.unit_price*il.quantity) as total_sales
from customer c 
join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
join track t on il.track_id = t.track_id
join album2 alb on alb.album_id=t.album_id
join best_selling_artist bsa on alb.artist_id=bsa.artist_id
group by customer_name,bsa.artist_name,bsa.artist_id
order by total_sales desc
limit 5;

/* 2. We want to find out the most popular music Genre for each country. We determine the 
most popular genre as the genre with the highest amount of purchases. Write a query 
that returns each country along with the top Genre. For countries where the maximum 
number of purchases is shared return all Genres                                           */

with popular_genre as (select count(il.quantity) as Purchases, c.country as country ,g.name,g.genre_id,
row_number () over(partition by c.country order by count(il.quantity) desc ) as row_no
from genre g 
join track t on g.genre_id = t.genre_id
join invoice_line il on t.track_id = il.track_id
join invoice i on il.invoice_id = i.invoice_id
join customer c on i.customer_id = c.customer_id
group by  country,g.name,g.genre_id
order by country asc, purchases desc
)
select * from popular_genre
where row_no = 1;



/*3. Write a query that determines the customer that has spent the most on music for each 
country. Write a query that returns the country along with the top customer and how
much they spent. For countries where the top amount spent is shared, provide all 
customers who spent this amount                     */

