
--1. Create a Stored Procedure that will insert a new film into the film table with the
--following arguments: title, description, release_year, language_id, rental_duration,
--rental_rate, length, replace_cost, rating
CREATE OR REPLACE PROCEDURE add_film(
	title VARCHAR(255), 
	description TEXT, 
	release_year INTEGER, 
	language_id INT, 
	rental_duration INT, 
	rental_rate NUMERIC(4,2), 
	length INT, 
	replacement_cost NUMERIC(5,2), 
	rating VARCHAR(10)
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO film(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, last_update)
	VALUES(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating:: mpaa_rating, now());
END;
$$;

CALL add_film('New Movie', 'You are now watching a new movie', 2000, 1, 5, 5.99, 130, 33.99, 'PG-13');

SELECT*
FROM film;


--2. Create a Stored Function that will take in a category_id and return the number of
--films in that category
CREATE OR REPLACE FUNCTION get_num_of_films(num INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
	DECLARE num_of_films INTEGER;
BEGIN
	SELECT COUNT(*) INTO num_of_films
	FROM film_category
	WHERE category_id = (num);
	RETURN num_of_films;
END;
$$;

SELECT get_num_of_films(10);

SELECT COUNT(category_id), category_id
FROM film_category
GROUP BY category_id;



