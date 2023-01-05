SELECT DISTINCT(name)
  FROM directors, ratings, people
 WHERE ratings.movie_id = directors.movie_id
   AND people.id = directors.person_id
   AND rating >= 9.0
