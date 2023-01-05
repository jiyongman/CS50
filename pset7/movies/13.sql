SELECT DISTINCT(name)
  FROM stars, people
 WHERE people.id = stars.person_id
   AND name != 'Kevin Bacon'
   AND movie_id IN
       (SELECT movie_id
          FROM stars, people
         WHERE people.id = stars.person_id
           AND name = 'Kevin Bacon'
           AND birth = 1958);
