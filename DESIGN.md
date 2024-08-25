# Design Document

By Tran Cao Nguyen aka Mr.Highland

Video overview: <URL https://youtu.be/WhO8se4FAMY>

## Scope

The database for website FLASHCARD includes all entities necessary to supports user to interact with the website. Including creating and deleting folders, sets; adding cards to a set; starting to review created sets and saving result. As such, included in the database'scopre is:
* User, including basic indentifying information
* Folders, including the title, the owner, and the time the folder was created
* Set, including the title, description, owner, folder to which it belongs (if any),  and the time the set was created
* Card, including the content and its meaning, the owner, the set it belongs to, and the time the card was created
* Review sessions, including the owner, the set user starting to review, the time it started, and the time it completed
* Card review, including the result of the card in a specific review session, the card_id, and the session_id

Out of scope are elements like comments, rates, and other non-core attributes.

## Functional Requirements

This database will support:

* CRUD operations for user
* Tracking all review session of a user, including multiple review sessions for the same set
* Tracking all the result in a specific review session

## Representation

### Entities

In this section you should answer the following questions:

* Which entities will you choose to represent in your database?
* What attributes will those entities have?
* Why did you choose the types you did?
* Why did you choose the constraints you did?

#### Users

The `users` table includes:

* `id`, which specifies the unique ID for the user as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `first_name`, which specifies the user's first name as `TEXT`, given `TEXT` is appropriate for name fields.
* `last_name`, which specifies the user's last name. `TEXT` is used for the same reason as `first_name`.
* `username`, which specifies the user's username. `TEXT` is used for the same reason as `first_name`. A `UNIQUE` constraint ensures no two users have the same username.
* `date_joined`, which specifies when the user began using the website. Timestamps in SQLite can be conveniently stored as `NUMERIC`, per SQLite documentation at <https://www.sqlite.org/datatype3.html>. The default value for the  `date_joined` attribute is the current timestamp, as denoted by `DEFAULT CURRENT_TIMESTAMP`.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` constraint is not.

#### Folders

The `folders` table includes:
* `id`, which specifies the unique ID for the folder as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `owner_id`, which is the ID of the user who created the folder as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `users` table to ensure data integerity.
* `title`, which specifies the folder's title as `TEXT`.
* `created_at`, which specifies when the folder was created. Timestamps in SQLite can be conveniently stored as `NUMERIC`, per SQLite documentation at <https://www.sqlite.org/datatype3.html>. The default value for the  `created_at` attribute is the current timestamp, as denoted by `DEFAULT CURRENT_TIMESTAMP`.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.

#### Sets

The `sets` table includes:
* `id`, which specifies the unique ID for the set as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `owner_id`, which is the ID of the user who created the set as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `users` table to ensure data integerity.
* `folder_id`, which is the ID of the folder to which the set belongs as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `users` table to ensure data integerity.
* `title`, which specifies the set's title as `TEXT`.
* `description`, which specifies the set's description as `TEXT`.
* `created_at`, which specifies when the set was created. Timestamps in SQLite can be conveniently stored as `NUMERIC`, per SQLite documentation at <https://www.sqlite.org/datatype3.html>. The default value for the  `created_at` attribute is the current timestamp, as denoted by `DEFAULT CURRENT_TIMESTAMP`.

All columns except `folder_id`, `description` are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.


#### Cards

The `cards` table includes:
* `id`, which specifies the unique ID for the card as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `owner_id`, which is the ID of the user who created the card as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `users` table to ensure data integerity.
* `set_id`, which is the ID of the set to which the card belongs as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `users` table to ensure data integerity.
* `content`, which specifies the card's content as `TEXT`.
* `meaning`, which specifies the meaning of the card's content as `TEXT`.
* `created_at`, which specifies when the card was created. Timestamps in SQLite can be conveniently stored as `NUMERIC`, per SQLite documentation at <https://www.sqlite.org/datatype3.html>. The default value for the  `created_at` attribute is the current timestamp, as denoted by `DEFAULT CURRENT_TIMESTAMP`.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.

#### Review sessions

The `review_sessions` table includes:
* `id`, which specifies the unique ID for the review session as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `user_id`, which is the ID of the user who started the review session as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `users` table to ensure data integerity.
* `set_id`, which is the ID of the set to which the card belongs as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `users` table to ensure data integerity.
* `started_at`, which specifies when the review session was started. Timestamps in SQLite can be conveniently stored as `NUMERIC`, per SQLite documentation at <https://www.sqlite.org/datatype3.html>. The default value for the  `created_at` attribute is the current timestamp, as denoted by `DEFAULT CURRENT_TIMESTAMP`.
* `ended_at`, which specifies when the review session was ended. Timestamps in SQLite can be conveniently stored as `NUMERIC`, per SQLite documentation at <https://www.sqlite.org/datatype3.html>.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.

#### Card reviews

The `card_reviews` table includes:
* `id`, which specifies the unique ID for the card review as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `card_id`, which is the ID of the card which was reviewed as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `cards` table to ensure data integerity.
* `session_id`, which is the ID of the session to which the card belongs as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `review_sessions` table to ensure data integerity.
* `result`, which is the result a card in a specific sesssion as an `ENUM` has value `True` or `False`.


All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.

### Relationships

The below entity relationship diagram describes the relationships among the entities in the database.
![ER Diagram](diagram.png)

* One user is capable of creating 0 to many folder, set, or card. 0, if they have yet create anything, and many if they create more than one folder, set, or card. A folder, set, or card is created by one and only one user. Besides that a user can start 0 to many review session. 0, if they have yet start review anything, many when they start more than 1 review session. A review session must belong to one and only one user.
* A folder can contain 0 to many sets. 0, if they don't contain anything, and many if they contain more than 1 set. A set can stay alone or belong to one and only one folder.
* A set can contain 1 to many cards. 1, if they have only 1 card, and many if they have more than 1 card. A card must belong to one and only one set. A set also has 0 to many review session. 0, if they have yet been reviewd, and many, if they were reviewed more than one time. A review session must review a specific set.
* A card has 0 to many card reviews. 0, if they have yet been review, and many, if they were reviewed more than one time. A card review must store the result of one and only one card in a specific session.

## Optimizations

Per the typical queries in `queries.sql`, it is common for users of the database to accesss all folders, sets base on their title or cards base on their set's title. For that reason, indexes are created on the `title` columns to speed the identification of folders, sets, or card by those columns.

## Limitations

The current schema can not classify the result of the cards, it just contains True or False and can not help user to recognize which card must be given the attention more than the other.

