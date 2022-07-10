use sakila;

SELECT * FROM actor;
SELECT * FROM rental;

-- 1)
SELECT a.actor_id, a.first_name, a.last_name, a.last_update
FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film f ON f.film_id=fa.film_id
WHERE title="ALABAMA DEVIL";

-- 2)
SELECT f.title, SUM(amount) as total_earned, COUNT(r.rental_id) AS number_of_rents
FROM film f
JOIN inventory i ON i.film_id=f.film_id
JOIN rental r ON r.inventory_id=i.inventory_id
JOIN payment p ON p.rental_id=r.rental_id
GROUP BY f.title
HAVING SUM(amount) > 110
ORDER BY SUM(amount) DESC;

-- 3)
SELECT f.title, COUNT(a.actor_id) as number_of_actors
FROM film f
JOIN film_actor fa ON fa.film_id=f.film_id
JOIN actor a ON a.actor_id=fa.actor_id
JOIN film_category fc ON fc.film_id=f.film_id
JOIN category c ON c.category_id=fc.category_id
WHERE c.name IN ("Action", "Animation", "Children", "Classics", "Comedy")
GROUP BY f.title
ORDER BY COUNT(a.actor_id) DESC;

-- 4)
SELECT c.first_name, c.last_name, f.title, COUNT(r.rental_id) AS total_time_rented
FROM customer c
JOIN rental r ON r.customer_id=c.customer_id
JOIN inventory i ON i.inventory_id=r.inventory_id
JOIN film f ON f.film_id=i.film_id
GROUP BY c.first_name, c.last_name, f.title
HAVING COUNT(r.rental_id) >= 2
ORDER BY COUNT(r.rental_id) DESC;




