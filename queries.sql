\c blog
-- SELECT * FROM categories LIMIT 5;
-- SELECT * FROM users LIMIT 5;
-- SELECT * FROM posts LIMIT 5;
-- SELECT * FROM comments LIMIT 5;

-- 1. How many comments has each user made per category?
-- select * from users;


  SELECT users.login, users.created_at, posts.title, posts.content as post_content, posts.created_at as post_date, categories.name as category_name, users2.login as commenter, comments.content as comment_content, comments.created_at as comment_date
  FROM users
    FULL OUTER JOIN posts
      ON users.id = posts.author_id
    FULL OUTER JOIN comments
      ON posts.id = comments.post_id
    FULL OUTER JOIN categories
      ON posts.category_id = categories.id
    LEFT OUTER JOIN users AS users2
      on comments.author_id = users2.id
          ORDER BY users.login
          ;

-- SELECT *
--     FROM users, posts
--     WHERE users.id = posts.author_id;

-- 2. Get a listing of all posts grouped by year.


-- 3. How many comments does each user have across all of their posts?


-- 4. Which posts contain a specific keyword?


-- 5. Which category of post has each user made the most comments on?


-- 6. Get a specific user's posts sorted by date of most recent comment.


-- 7. Get all posts by a specific user that have comments, but which that user *hasn't* commented on.


-- 8. Get the top 5 most-commented-on posts that were created in the last 7 days.


-- 9. Get the top 5 wordiest posts (just by character count &ndash; don't actually count words).


-- 10. Get all posts sorted by longest-running comment thread (time between first and last comments).
