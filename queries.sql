\c blog
-- SELECT * FROM categories LIMIT 5;
-- SELECT * FROM users LIMIT 5;
-- SELECT * FROM posts LIMIT 5;
-- SELECT * FROM comments LIMIT 5;

  -- SELECT users.login, users.created_at, posts.title, posts.content as post_content, posts.created_at as post_date, categories.name as category_name, users2.login as commenter, comments.content as comment_content, comments.created_at as comment_date
  -- FROM users
  --   FULL OUTER JOIN posts
  --     ON users.id = posts.author_id
  --   FULL OUTER JOIN comments
  --     ON posts.id = comments.post_id
  --   FULL OUTER JOIN categories
  --     ON posts.category_id = categories.id
  --   LEFT OUTER JOIN users AS users2
  --     ON comments.author_id = users2.id
  --         ORDER BY users.login;




-- 1. How many comments has each user made per category?


  SELECT users2.login as commenter, categories.name as category_name, count (users2.login)
  FROM users
    FULL OUTER JOIN posts
      ON users.id = posts.author_id
    FULL OUTER JOIN comments
      ON posts.id = comments.post_id
    FULL OUTER JOIN categories
      ON posts.category_id = categories.id
    LEFT OUTER JOIN users AS users2 -- needed an alias
      ON comments.author_id = users2.id
          WHERE users2.login <> ''
            GROUP BY commenter, category_name
              ORDER BY users2.login;




-- 2. Get a listing of all posts grouped by year.
  SELECT DISTINCT posts.id, EXTRACT(year from posts.created_at::date) as year, posts.content AS post_content, users.login AS poster
  FROM users
    FULL OUTER JOIN posts
      ON users.id = posts.author_id
    FULL OUTER JOIN comments
      ON posts.id = comments.post_id
    FULL OUTER JOIN categories
      ON posts.category_id = categories.id
    LEFT OUTER JOIN users AS users2
      ON comments.author_id = users2.id
          ORDER BY year;

-- 3. How many comments does each user have across all of their posts?
  SELECT users.login, count(comments.content) as total_comments_on_all_posts
  FROM users
    FULL OUTER JOIN posts
      ON users.id = posts.author_id
    FULL OUTER JOIN comments
      ON posts.id = comments.post_id
    FULL OUTER JOIN categories
      ON posts.category_id = categories.id
    LEFT OUTER JOIN users AS users2
      ON comments.author_id = users2.id
          GROUP BY users.login
            ORDER BY users.login;

-- 4. Which posts contain a specific keyword?
  SELECT DISTINCT users.login, posts.title, posts.content as post_content, posts.created_at as post_date -- will repeat for every comment otherwise
  FROM users
    FULL OUTER JOIN posts
      ON users.id = posts.author_id
    FULL OUTER JOIN comments
      ON posts.id = comments.post_id
    FULL OUTER JOIN categories
      ON posts.category_id = categories.id
    LEFT OUTER JOIN users AS users2
      ON comments.author_id = users2.id
        WHERE posts.content like '%about%'
            ORDER BY users.login;

-- 5. Which category of post has each user made the most comments on?
-- DISTINCT ON is the postgres method

  SELECT DISTINCT ON (users2.login) users2.login as commenter, categories.name as category_name, COUNT(categories.name) AS count
  FROM users
    FULL OUTER JOIN posts
      ON users.id = posts.author_id
    FULL OUTER JOIN comments
      ON posts.id = comments.post_id
    FULL OUTER JOIN categories
      ON posts.category_id = categories.id
    LEFT OUTER JOIN users AS users2
      ON comments.author_id = users2.id
        WHERE users2.login <> ''
          GROUP BY users2.login, categories.name
            ORDER BY users2.login, count(categories.name)DESC;



-- 6. Get a specific user's posts sorted by date of most recent comment.
  SELECT users.login, posts.title, posts.content as post_content, posts.created_at as post_date, comments.created_at as comment_date, users2.login as commenter
  FROM users
    FULL OUTER JOIN posts
      ON users.id = posts.author_id
    FULL OUTER JOIN comments
      ON posts.id = comments.post_id
    FULL OUTER JOIN categories
      ON posts.category_id = categories.id
    LEFT OUTER JOIN users AS users2
      ON comments.author_id = users2.id
        WHERE (users.login = 'Jill')
          ORDER BY comments.created_at DESC;

-- 7. Get all posts by a specific user that have comments, but which that user *hasn't* commented on.
  SELECT users.login, posts.title, posts.content as post_content, posts.created_at as post_date, comments.created_at as comment_date, users2.login
  FROM users
    FULL OUTER JOIN posts
      ON users.id = posts.author_id
    FULL OUTER JOIN comments
      ON posts.id = comments.post_id
    FULL OUTER JOIN categories
      ON posts.category_id = categories.id
    LEFT OUTER JOIN users AS users2
      ON comments.author_id = users2.id
        WHERE (users.login = 'George' and users2.login <> '' and users2.login <> 'George')
          ORDER BY comments.created_at DESC;--removed those with no comment

-- 8. Get the top 5 most-commented-on posts that were created in the last 7 days.
  SELECT posts.title as post_title, count(comments.content) as count_of_comments, max(comments.created_at) as most_recent_comment_date_
  FROM users
    FULL OUTER JOIN posts
      ON users.id = posts.author_id
    FULL OUTER JOIN comments
      ON posts.id = comments.post_id
    FULL OUTER JOIN categories
      ON posts.category_id = categories.id
    LEFT OUTER JOIN users AS users2
      ON comments.author_id = users2.id
          WHERE comments.created_at >= current_date - interval '7 days'
            GROUP BY posts.title
              ORDER BY count(comments.content) DESC, max(comments.created_at) DESC LIMIT 5;

-- 9. Get the top 5 wordiest posts (just by character count &ndash; don't actually count words).
  SELECT users.login, users.created_at, posts.title, posts.content as post_content, CHAR_LENGTH(posts.content), posts.created_at as post_date, categories.name as category_name
  FROM users
    FULL OUTER JOIN posts
      ON users.id = posts.author_id
    FULL OUTER JOIN comments
      ON posts.id = comments.post_id
    FULL OUTER JOIN categories
      ON posts.category_id = categories.id
    LEFT OUTER JOIN users AS users2
      ON comments.author_id = users2.id
          WHERE posts.content <> ''
            ORDER BY CHAR_LENGTH(posts.content) DESC LIMIT 5;

-- 10. Get all posts sorted by longest-running comment thread (time between first and last comments).

  SELECT posts.title, MAX(comments.created_at) AS latest_comment, MIN(comments.created_at) AS earliest_comment, MAX(comments.created_at) - MIN(comments.created_at) AS duration, COUNT(comments.created_at)
  FROM users
    FULL OUTER JOIN posts
      ON users.id = posts.author_id
    FULL OUTER JOIN comments
      ON posts.id = comments.post_id
    FULL OUTER JOIN categories
      ON posts.category_id = categories.id
    LEFT OUTER JOIN users AS users2
      ON comments.author_id = users2.id
        WHERE (comments.content <> '')
          GROUP BY posts.title
            HAVING (COUNT(comments.created_at)>1)
              ORDER BY duration DESC
            ;

