--1. What grades are stored in the database?
  SELECT    *
    FROM    Grade;

--2. What emotions may be associated with a poem?
  SELECT    *
    FROM    Emotion;

--3. How many poems are in the database?
  SELECT    COUNT(*)
    FROM    Poem;

--4. Sort authors alphabetically by name. What are the names of the top 76 authors?
  SELECT    TOP 76 *
    FROM    Author
ORDER BY    Name;

--5. Starting with the above query, add the grade of each of the authors.
  SELECT    TOP 76 *
    FROM    Author a
            LEFT JOIN Grade g
            ON a.GradeId = g.Id
ORDER BY    a.Name;

--6. Starting with the above query, add the recorded gender of each of the authors.
  SELECT    TOP 76 *
    FROM    Author a
            LEFT JOIN Grade g
            ON a.GradeId = g.Id
            LEFT JOIN Gender ge
            ON a.GenderId = ge.Id
ORDER BY    a.Name;

--7. What is the total number of words in all poems in the database?
  SELECT    SUM(WordCount)
    FROM    Poem;

--8. Which poem has the fewest characters?
  SELECT    TOP 1 Title, CharCount
    FROM    Poem
ORDER BY    CharCount;

--9. How many authors are in the third grade?
  SELECT    COUNT(*)
    FROM    Author
   WHERE    GradeId = 3;

--10. How many authors are in the first, second or third grades?
  SELECT    COUNT(*)
    FROM    Author
   WHERE    GradeId = 3
            OR GradeId = 2
            OR GradeId = 1;

--11. What is the total number of poems written by fourth graders?
  SELECT    COUNT(*)
    FROM    Poem p
            LEFT JOIN Author a
            ON p.AuthorId = a.Id
   WHERE    a.GradeId = 4;

--12. How many poems are there per grade?
  SELECT    g.Name, COUNT(p.Id) AS Poems
    FROM    Poem p
            LEFT JOIN Author a
            ON p.AuthorId = a.Id
            LEFT JOIN Grade g
            ON a.GradeId = g.Id
GROUP BY    g.Name
ORDER BY    g.Name;

--13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)
  SELECT    g.Name, COUNT(a.Id) AS ArtistCount
    FROM    Author a
            LEFT JOIN Grade g
            ON a.GradeId = g.Id
GROUP BY    g.Name
ORDER BY    g.Name

--14. What is the title of the poem that has the most words?
  SELECT    TOP 1 Title, WordCount
    FROM    Poem
ORDER BY    WordCount DESC;

--15. Which author(s) have the most poems? (Remember authors can have the same name.)
  SELECT    TOP 5 p.AuthorId, a.Name, COUNT(p.Id) AS PoemCount
    FROM    Author a
            LEFT JOIN  Poem p
            ON a.Id = p.AuthorId
GROUP BY    p.AuthorId, a.Name
ORDER BY    PoemCount DESC;

--16. How many poems have an emotion of sadness?
  SELECT    e.Name, COUNT(p.Id) AS PoemCount
    FROM    Poem p
            LEFT JOIN PoemEmotion pe
            ON p.Id = pe.PoemId
            LEFT JOIN Emotion e
            ON pe.EmotionId = e.Id
GROUP BY    e.Name
  HAVING    e.Name = 'sadness';

--17. How many poems are not associated with any emotion?
  SELECT    e.Name, COUNT(p.Id) AS PoemCount
    FROM    Poem p
            LEFT JOIN PoemEmotion pe
            ON p.Id = pe.PoemId
            LEFT JOIN Emotion e
            ON pe.EmotionId = e.Id
GROUP BY    e.Name
  HAVING    e.Name IS NULL;



--18. Which emotion is associated with the least number of poems?
  SELECT    TOP 1 e.Name, COUNT(p.Id) AS PoemCount
    FROM    Poem p
            LEFT JOIN PoemEmotion pe
            ON p.Id = pe.PoemId
            LEFT JOIN Emotion e
            ON pe.EmotionId = e.Id
GROUP BY    e.Name
  HAVING    e.name IS NOT NULL
ORDER BY    PoemCount;

--19. Which grade has the largest number of poems with an emotion of joy?
  SELECT    TOP 1 g.Name AS Grade, e.Name AS Emotion, COUNT(p.Id) AS PoemCount
    FROM    Grade g
            LEFT JOIN Author a
            ON g.Id = a.GradeId
            LEFT JOIN Poem p
            ON a.Id = p.AuthorId
            LEFT JOIN PoemEmotion pe
            ON  p.Id = pe.PoemId
            LEFT JOIN Emotion e
            ON pe.EmotionId = e.Id
GROUP BY    g.Name, e.Name
  HAVING    e.Name = 'joy'
ORDER BY    PoemCount DESC;

--20. Which gender has the least number of poems with an emotion of fear?

SELECT PoemId, EmotionId
FROM PoemEmotion
WHERE EmotionId = 3
GROUP BY

SELECT DISTINCT COUNT(PoemId)
FROM PoemEmotion
WHERE EmotionId = 3
