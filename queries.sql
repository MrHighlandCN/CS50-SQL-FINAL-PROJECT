-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database
-- Add a new user
INSERT INTO "users" ("first_name", "last_name", "username", "password")
VALUES
('Nguyen', 'Tran', 'MrHighland', '12345678'),
('Quan', 'Hoang', 'MinhQuan', '12345678'),
('Binh', 'Vo', 'QuocBinh', '12345678');


-- Add a new folder
INSERT INTO "folders" ("owner_id", "title")
VALUES
(1, 'Folder 1'),
(1, 'Folder 2'),
(1, 'Folder 3');


-- Add a new set
INSERT INTO "sets" ("owner_id", "folder_id", "title", "description")
VALUES
(1, 1, 'Set 1', 'This is the first set'),
(1, 2, 'Set 2', 'This is the second set'),
(1, 1, 'Set 3', 'This is the third set');

-- Add a new card
INSERT INTO "cards" ("owner_id", "set_id", "content", "meaning")
VALUES
(1, 1, 'computer science', 'the study of computers and how they can be used'),
(1, 1, 'course', 'a set of classes or a plan of study on a particular subject, usually leading to an exam or qualification'),
(1, 1, 'database', 'a large amount of information stored in a computer system in such a way that it can be easily looked at or changed');

-- Find all folders given their title
SELECT * FROM "folders"
WHERE "title" = "Folder 1";

-- Find all sets given their title
SELECT * FROM "sets"
WHERE "title" = "Set 1";

-- Find all cards for a given set
SELECT * FROM "cards"
WHERE "set_id" = (
    SELECT "id" FROM "sets"
    WHERE "title" = "Set 1"
);

