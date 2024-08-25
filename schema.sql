-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Represent users using the app
CREATE TABLE IF NOT EXISTS "users" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    "date_joined" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id")
);

-- Represent folders in the app
CREATE TABLE IF NOT EXISTS "folders"(
    "id" INTEGER,
    "owner_id" INTEGER,
    "title" TEXT NOT NULL,
    "created_at" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("owner_id") REFERENCES "users"("id") ON DELETE CASCADE
);

-- Represent sets in the app
CREATE TABLE IF NOT EXISTS "sets"(
    "id" INTEGER,
    "owner_id" INTEGER,
    "folder_id" INTEGER NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "created_at" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("owner_id") REFERENCES "users"("id") ON DELETE CASCADE,
    FOREIGN KEY("folder_id") REFERENCES "folders"("id") ON DELETE SET NULL
);


-- Represent cards in a set
CREATE TABLE IF NOT EXISTS "cards" (
    "id" INTEGER,
    "owner_id" INTEGER,
    "set_id" INTEGER,
    "content" TEXT NOT NULL,
    "meaning" TEXT NOT NULL,
    "created_at" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("owner_id") REFERENCES "users"("id") ON DELETE CASCADE,
    FOREIGN KEY("set_id") REFERENCES "sets"("id") ON DELETE CASCADE
);


-- Represent a review session of user
CREATE TABLE IF NOT EXISTS "review_sessions"(
    "id" INTEGER,
    "user_id" INTEGER,
    "set_id" INTEGER,
    "started_at" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ended_at" NUMERIC NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id") ON DELETE CASCADE,
    FOREIGN KEY("set_id") REFERENCES "sets"("id") ON DELETE CASCADE
);


-- Represent the result of a card in a review session
CREATE TABLE IF NOT EXISTS "card_reviews"(
    "id" INTEGER,
    "card_id" INTEGER,
    "session_id" INTEGER,
    "result" TEXT NOT NULL CHECK("result" IN ('True', 'False')),
    PRIMARY KEY("id"),
    FOREIGN KEY("card_id") REFERENCES "cards"("id") ON DELETE CASCADE,
    FOREIGN KEY("session_id") REFERENCES "review_sessions"("id") ON DELETE CASCADE

);

CREATE INDEX IF NOT EXISTS "folder_title_search" ON "folders"("title");
CREATE INDEX IF NOT EXISTS "set_title_search" ON "sets"("title");
