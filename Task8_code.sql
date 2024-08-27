---CREATE DATABASE---

CREATE DATABASE IMDB;
USE IMDB;


---CREATE TABLES---

--1) Movies Table - Contains details about movies.

CREATE TABLE Movies(movie_ID INT AUTO_INCREMENT PRIMARY KEY, movie_name Varchar(255));

--Insert values into the table

INSERT INTO Movies (Movie_Name) VALUES ("Avatar The Last Airbender"),
("Naruto") , ("Harry Potter") , ("Iron Man"), ("Pokemon") , ("Thor Ragnarok");
SELECT * from Movies;

--2) Media Table - Multiple media like video or images(comic).

CREATE TABLE Media(media_ID INT AUTO_INCREMENT PRIMARY KEY, movie_ID INT, media_type VARCHAR(255),
FOREIGN KEY (movie_ID) REFERENCES Movies(movie_ID));

--Insert values into the table

INSERT INTO Media (movie_ID,media_type) VALUES (1,'Video'), (2,'image'),(3,'image'),(4,'video'),(5,'video'),(6,'video');

Select * from Media;

--3) Genre Table - Various Genres

CREATE TABLE Genre(
genre_ID INT AUTO_INCREMENT PRIMARY KEY,
genre_name VARCHAR(255));

--Insert values into the table

INSERT INTO Genre (genre_name) VALUES ('Action'),('Adventure'), ('Fantasy'),('comic'),('Fantasy Literature'),
                                       ('Superhero fiction'),('Animation'),('Comedy');

Select * from Genre;

--4) MovieGenre Table - Movies have multiple genres.

Create Table MovieGenre(movie_ID INT, genre_ID INT,
FOREIGN KEY (movie_ID) REFERENCES Movies(movie_ID),
FOREIGN KEY (genre_ID) REFERENCES Genre (genre_ID));

--Insert values into the table

INSERT INTO MovieGenre (movie_ID, genre_ID) VALUES (1,1),(1,2),(1,3),(2,2),(2,3),(2,4),(3,5),(4,6),(5,2),(5,7),(6,6);

Select * from MovieGenre;

--5) User Table - Contains User information.

CREATE TABLE User(
user_ID INT AUTO_INCREMENT PRIMARY KEY,
user_name VARCHAR(255));

--Insert values into the table

Insert into User (user_name) VALUES ('Sam'),('Ash'),('Serena'),('Harry'),('Shree');

--Retrive records from the table
SELECT * from User;

--6) Reviews Table - Stores reviews for movies.

Create TABLE MovieReview(movie_ID INT, user_ID INT, review VARCHAR (255),
FOREIGN KEY (movie_ID) REFERENCES Movies (movie_ID),
FOREIGN KEY (user_ID) REFERENCES User (user_ID));

--Insert values into the table

INSERT INTO MovieReview (movie_ID, user_ID, review) VALUES (4,1,'Very Good'), (6,1,'Good'), (5,2,'Excellent'),
(5,3,'Very Good'), (3,4,'Average'), (2,5,'Good'), (1,5,'Excellent');

--Retrive records from the table
SELECT * from MovieReview;

--7)Artists Table - Contains information about artists.

CREATE TABLE Artists(
artist_ID INT AUTO_INCREMENT PRIMARY KEY,
artist_name VARCHAR (255));

--Insert values into the table

INSERT INTO Artists (artist_name) VALUES ('Michael DiMartino'),('Masashi Kishimoto'),
('Daniel Radcliffe'),('Robert Downey Jr.'),('Satoshi Tajiri'),('Chris Hemsworth');

--Retrive records from the table
SELECT * FROM Artists;

--8) Skills Table - Contains different skills an artist can have.

CREATE TABLE Skills(skill_ID INT AUTO_INCREMENT PRIMARY KEY,
skill_name VARCHAR (255));

--Insert values into the table

INSERT INTO Skills (skill_name) VALUES ('Actor'),('Author'),('Director'),('Creator');

--Retrive records from the table
SELECT * FROM Skills;

--9) ArtistSkills Table - Associates artists with their skills.

CREATE TABLE ArtistSkills ( artist_ID INT, skill_ID INT,
FOREIGN KEY (artist_ID) REFERENCES Artists(artist_ID),
FOREIGN KEY (skill_ID) REFERENCES Skills (skill_ID));

--Insert values into the table

INSERT INTO ArtistSkills (artist_ID,skill_ID) VALUES (1,2),(2,4),(3,1),(4,1),(5,2),(6,1);

--Retrive records from the table
SELECT * FROM Artist_Skills;

--10) Roles Table - Contains the roles in movies.

CREATE TABLE Roles (
role_id INT AUTO_INCREMENT PRIMARY KEY,
role_name VARCHAR(100));

--Insert values into the table

INSERT INTO Roles (role_name) VALUES ('Lead Role'),('Voice Actor'),('Superhero');

--11) ArtistRoles Table - Artists roles in movies.

CREATE TABLE ArtistRoles (artist_id INT, movie_id INT, role_id INT,
FOREIGN KEY (artist_id) REFERENCES Artists(artist_id),
FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
FOREIGN KEY (role_id) REFERENCES Roles(role_id));

--Insert values into the table

INSERT INTO ArtistRoles (artist_id, movie_id, role_id) VALUES
(1, 1, 2),(2, 2, 2),(3, 3, 1),(4, 4, 1),(4, 4, 3),(5, 5, 2),(6, 6, 1),(6, 6, 3);

--- Movie should have multiple media(Video or Image)---

Select Movies.movie_ID, Movies.movie_name, Media.media_type
FROM Movies
INNER JOIN Media ON Media.movie_ID = Movies.movie_ID;

---Movie can belongs to multiple Genre---

SELECT Movies.movie_ID, Movies.movie_name, Genre.genre_name
FROM Movies
INNER JOIN MovieGenre ON Movies.movie_ID = MovieGenre.movie_ID
INNER JOIN Genre ON MovieGenre.genre_ID = Genre.genre_ID;

--- Movie can have multiple reviews and Review can belongs to a user---

SELECT User.user_name, Movies.movie_ID, Movies.movie_name, MovieReview.review
FROM Movies
INNER JOIN MovieReview ON MovieReview.movie_ID = Movies.movie_ID
INNER JOIN User ON User.user_ID = MovieReview.user_ID;

---Artist can have multiple skills---

Select Artists.artist_name, ArtistSkills.skill_ID, Skills.skill_name
FROM Artists
INNER JOIN ArtistSkills ON ArtistSkills.artist_ID = Artists.artist_ID
INNER JOIN Skills ON Skills.skill_ID = ArtistSkills.skill_ID;

---Artist can perform multiple role in a single film---

SELECT Artists.artist_name, Movies.movie_name, Roles.role_name
FROM ArtistRoles
INNER JOIN Artists ON ArtistRoles.artist_ID = Artists.artist_ID
INNER JOIN Roles ON ArtistRoles.role_ID = Roles.role_ID
INNER JOIN Movies ON ArtistRoles.movie_ID = Movies.movie_ID;



