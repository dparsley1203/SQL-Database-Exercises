--query all of the entries in the genre table

select *
from genre

--query all the entries in the artist table and order by the artist's name. hint: use the order by keywords

SELECT *
FROM Artist
ORDER By ArtistName;

--write a select query that lists all the songs in the song table and include the artist name

SELECT 
	s.Title, 
	a.ArtistName
FROM Song s
INNER JOIN Artist a ON s.ArtistId = a.id

--write a select query that lists all the artists that have a soul album

SELECT DISTINCT ar.ArtistName, g.Name
FROM Artist ar
JOIN Album al ON al.ArtistId = ar.id
JOIN Genre g ON al.GenreId = g.id
WHERE g.Name = 'Soul'



--write a select query that lists all the artists that have a jazz or rock album

SELECT DISTINCT ar.ArtistName, g.Name
FROM Artist ar
JOIN Album al ON al.ArtistId = ar.id
JOIN Genre g ON al.GenreId = g.id
WHERE g.Name = 'Rock'
OR g.Name = 'Jazz'


--write a select statement that lists the albums with no songs

SELECT al.Title Album, s.Title Song
FROM Album al
LEFT JOIN Song s ON al.id = s.AlbumId
WHERE s.Title IS NULL



--using the insert statement, add one of your favorite artists to the artist table.

SELECT *
FROM Artist

INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Chevelle', 2005)


--using the insert statement, add one, or more, albums by your artist to the album table.

SELECT * 
FROM Album

SELECT *
FROM Genre

INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('The Red', '12/03/2010', 2145, 'Blue', 29, 2)


--using the insert statement, add some songs that are on that album to the song table.

SELECT *
FROM Song

INSERT INTO Song(Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Closure', 222, '12/04/2015', 2, 29, 23)
INSERT INTO Song(Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Jump', 225, '12/04/2015', 2, 29, 23)


--write a select query that provides the song titles, album title, and artist name for all of the data you just entered in. use the left join keyword sequence to connect the tables, and the where keyword to filter the results to the album and artist you added.

SELECT s.Title Song, al.Title Album, ar.ArtistName Artist
FROM Song s
JOIN Album al ON al.id = s.AlbumId
JOIN Artist ar ON ar.id = al.ArtistId
WHERE ar.ArtistName = 'Chevelle'

--note: direction of join matters. try the following statements and see the difference in results.

select 
	a.title Album, 
	s.title Song 
from 
	album a 
left join 
	song s on 
	s.albumid = a.id;

select 
	a.title Album, 
	s.title Song 
from 
	song s 
right join 
	album a on 
	s.albumid = a.id;

select a.title Album, s.title Song from song s full join album a on s.albumid = a.id;


--write a select statement to display how many songs exist for each album. you'll need to use the count() function and the group by keyword sequence.

Select Count(s.id) As NumOfSongs, al.Title
From Song s
Join Album al On s.AlbumId = al.Id
Group By al.Title




--write a select statement to display how many songs exist for each artist. you'll need to use the count() function and the group by keyword sequence.

Select ar.ArtistName, count(s.id) As NumOfSongs
From Song s
Join Artist ar On ar.id = s.ArtistId
Group By ar.ArtistName



--write a select statement to display how many songs exist for each genre. you'll need to use the count() function and the group by keyword sequence.

Select g.Name, count(s.id) as NumOfSongs
From Song s 
Join Genre g On g.id = s.GenreId
Group By g.Name

Select *
From Genre



--write a select query that lists the artists that have put out records on more than one record label. hint: when using group by instead of using a where clause, use the having keyword

Select ar.ArtistName, Count(distinct al.Label) NumOfLabels
From Artist ar
Full Join Album al On ar.id = al.ArtistId
Group By ar.ArtistName
Having Count(distinct al.Label) > 1



--using max() function, write a select statement to find the album with the longest duration. the result should display the album title and the duration.

Select al.Title, al.AlbumLength
From Album al
Group by al.Title, al.AlbumLength
Having Max(al.AlbumLength) >= 3500


Select Top(1) Title, AlbumLength
From Album
Order by AlbumLength desc

select Title, AlbumLength
from Album
Where AlbumLength = (select max(AlbumLength) from Album)








--using max() function, write a select statement to find the song with the longest duration. the result should display the song title and the duration.

Select s.Title, s.SongLength
From Song s
Where s.SongLength = (select max(s.SongLength) from Song s)



--modify the previous query to also display the title of the album.

Select s.Title, s.SongLength, al.Title
From Song s
Join Album al on al.id = s.AlbumId
Where s.SongLength = (select max(s.SongLength) from Song s)