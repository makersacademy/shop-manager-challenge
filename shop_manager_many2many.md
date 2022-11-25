# Designing Many-to-many relationships

_**This is a Makers Bite.** Bites are designed to train specific skills or
tools. They contain an intro, a demonstration video, some exercises with an
example solution video, and a challenge without a solution video for you to test
your learning. [Read more about how to use Makers
Bites.](https://github.com/makersacademy/course/blob/main/labels/bites.md)_

Learn to design a many-to-many relationship between two tables.

## Intro

A many-to-many relationship is needed when a record from the first table can have _many_ records in the other table, but the opposite is also true.

You can recognise the need for a many-to-many relationship when you can answer "yes" to the following questions:

1. Can one [TABLE ONE] have many [TABLE TWO]?
2. Can one [TABLE TWO] have many [TABLE ONE]?

As an example: a blog post can have many tags. But a tag can also be associated with many posts.

1. Can a _post_ have many _tags_? - Yes
1. Can a _tag_ have many _posts_? - Yes

When designing a many-to-many relationship, you will need a third table, acting as a "link" between to the tables. This is called a **join table**. It contains two columns, which are two foreign keys, each linking to the two tables.

## Design Recipe

You can follow steps from this [Design Recipe](../resources/two_tables_many_to_many_design_recipe_template.md) to design the schema for two related tables with a Many-to-Many relationship.

<!-- OMITTED -->

## Exercise

Infer the table schema from these user stories.

```
As a coach
So I can get to know all students
I want to keep a list of students' names.

As a coach
So I can get to know all students
I want to assign tags to students (for example, "happy", "excited", etc).

As a coach
So I can get to know all students
I want to be able to assign the same tag to many different students.

As a coach
So I can get to know all students
I want to be able to assign many different tags to a student.
```

1. Copy the Design Recipe template and use it to design the schema for the two tables and their join table.
2. Create the tables by loading the SQL file in `psql`.

## Challenge

Infer the table schema from these user stories.

```
As a cinema company manager,
So I can keep track of movies being shown,
I want to keep a list of movies with their title and release date.

As a cinema company manager,
So I can keep track of movies being shown,
I want to keep a list of my cinemas with their city name (e.g 'London' or 'Manchester').

As a cinema company manager,
So I can keep track of movies being shown,
I want to be able to list which cinemas are showing a specific movie.

As a cinema company manager,
So I can keep track of movies being shown,
I want to be able to list which movies are being shown a specific cinema.
```

1. Copy the Design Recipe template and use it to design the schema for the two tables and their join table.
2. Create the tables by loading the SQL file in `psql`.


[Next Challenge](05_repository_classes_many_to_many.md)

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=joins%2F04_designing_many_to_many_relationships.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=joins%2F04_designing_many_to_many_relationships.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=joins%2F04_designing_many_to_many_relationships.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=joins%2F04_designing_many_to_many_relationships.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=joins%2F04_designing_many_to_many_relationships.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->