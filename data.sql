\c blog

INSERT INTO users (login)
  (VALUES
    ('Kelly'),
    ('Chris'),
    ('Kim'),
    ('Jack'),
    ('Jill'),
    ('Went'),
    ('Hill'),
    ('Owen'),
    ('Mira'),
    ('Meghan'),
    ('Carol'),
    ('Christopher'),
    ('George'),
    ('Alan'),
    ('Bryan'),
    ('Missy'),
    ('Dana'),
    ('Tanya'),
    ('Sue'),
    ('Mary'),
    ('Stevie'),
    ('Alex')
    );

INSERT INTO categories (name)
  (VALUES
    ('Music'),
    ('Books'),
    ('Technology'),
    ('Dating'),
    ('Lifehacks'),
    ('Venture Capital')
    );

-- Create blog posts

WITH temp (login, title, content, category, created_at) AS
(VALUES
  ('Kelly', 'Title 01', 'Content of blog post the best pizza.', 'Books', '2014-4-30'),
  ('Chris', 'Title 02', 'Content of blog post tshirts are dumb.', 'Music', '2014-4-12'),
  ('Kim', 'Title 03', 'Content of blog post the secret to life.', 'Technology', '2014-4-2'),
  ('Jack', 'Title 04', 'Content of blog post about god.', 'Music', '2014-4-3'),
  ('Jill', 'Title 05', 'Content of blog post about dogs.', 'Technology', '2014-1-30'),
  ('Went', 'Title 06', 'Content of blog post about the best fishing holes.', 'Music', '2014-1-30'),
  ('Hill', 'Title 07', 'Content of blog post whoa.', 'Technology', '2014-4-11'),
  ('Owen', 'Title 08', 'Content of blog post fun stuff.', 'Music', '2014-5-1'),
  ('Mira', 'Title 09', 'Content of blog post dogs.', 'Technology', '2014-3-30'),
  ('Meghan', 'Title 10', 'Content of blog post applejacks.', 'Music', '2012-4-30'),
  ('Carol', 'Title 11', 'Content of blog post happy people.', 'Books', '2012-2-22'),
  ('Chris', 'Title 12', 'Content of blog post alphabets.', 'Music', '2011-4-29'),
  ('George', 'Title 13', 'Content of blog post so what.', 'Books', '2015-3-30'),
  ('Alan', 'Title 14', 'Content of blog post i do not know.', 'Music', '2014-1-22'),
  ('Bryan', 'Title 15', 'Content of blog post cereals.', 'Books', '2013-2-14'),
  ('Missy', 'Title 16', 'Content of blog post fencing.', 'Music', '2010-4-30'),
  ('Dana', 'Title 17', 'Content of blog post tables that ar big.', 'Venture Capital', '2012-3-24'),
  ('Tanya', 'Title 18', 'Content of blog post garage bands.', 'Music', '2014-2-28'),
  ('Sue', 'Title 19', 'Content of blog post video games.', 'Books', '2013-1-30'),
  ('Mary', 'Title 20', 'Content of blog post sooo I have data here.', 'Music', '2011-2-22'),
  ('Stevie', 'Title 21', 'Content of blog post camel case.', 'Technology', '2014-4-25'),
  ('Alex', 'Title 22', 'Content of blog post super computer.', 'Music', '2013-1-30'),
  ('Carol', 'Title 23', 'Content of blog post ghost busters.', 'Technology', '2012-3-30'),
  ('Carol', 'Title 24', 'Content of blog post back when I had a life.', 'Music', '2011-5-20'),
  ('George', 'Title 25', 'Content of blog post Boston.', 'Lifehacks', '2014-1-1'),
  ('Alan', 'Title 26', 'Content of blog post states.', 'Dating', '2011-4-1'),
  ('Bryan', 'Title 27', 'Content of blog post cities.', 'Venture Capital', '2012-11-30'),
  ('George', 'Title 28', 'Content of blog post whaaatttt.', 'Music', '2014-12-30'),
  ('Dana', 'Title 29', 'Content of blog post go for it.', 'Lifehacks', '2014-6-30'),
  ('Tanya', 'Title 30', 'Content of blog post so what.', 'Dating', '2012-4-30'),
  ('Jill', 'Title 31', 'Content of bp.', 'Lifehacks', '2012-4-23'),
  ('Mary', 'Title 32', 'Content of blog great work methods.', 'Dating', '2013-5-17'),
  ('Alan', 'Title 33', 'Content of blog post 99.', 'Music', '2013-9-30'),
  ('Stevie', 'Title 34', 'Content of blog post 1000.', 'Venture Capital', '2013-5-20'),
  ('George', 'Title 35', 'Content of blog post car stuff.', 'Music', '2012-2-14'),
  ('Tanya', 'Title 36', 'Content of blog post what about bob.', 'Venture Capital', '2013-1-12'),
  ('Tanya', 'Title 37', 'Content of blog post go on.', 'Music', '2014-4-30'),
  ('Jill', 'Title 38', 'Content of blog post and on and on.', 'Venture Capital', '2012-11-11'),
  ('Tanya', 'Title 39', 'Content of blog post supertroopers.', 'Music', '2009-9-19')
)
INSERT INTO posts
  (author_id, title, content, category_id, created_at)
SELECT
  users.id, temp.title, temp.content, categories.id, temp.created_at::date
FROM
  users JOIN temp
    ON temp.login = users.login
    JOIN categories
      ON temp.category = categories.name;

-- Create comments

WITH temp (login, title, content, created_at) AS
(VALUES
  ('Dana', 'Title 12', 'Random comments asdfsdf.', '2012-4-29'),
  ('Alan', 'Title 13', 'Random comments soo.', '2016-3-30'),
  ('Missy', 'Title 14', 'Random comments no me gusta.', '2015-1-22'),
  ('Carol', 'Title 15', 'Random comments whatever', '2013-3-30'),
  ('Christopher', 'Title 16', 'Random comments of blog post fencing.', '2010-6-30'),
  ('Tanya', 'Title 17', 'Random comments of how goes it.', '2012-9-24'),
  ('Sue', 'Title 18', 'Random comments of i am confused?.', '2014-2-21'),
  ('George', 'Title 19', 'Random comments video games.', '2013-8-30'),
  ('Alex', 'Title 12', 'Random comments of blog post sooo I have data here.','2012-2-22'),
  ('Bryan', 'Title 21', 'Random comments of blog post camel case is better.', '2014-5-25'),
  ('Jack', 'Title 22', 'Random comments of blog post super computer is best.', '2013-7-30'),
  ('Jill', 'Title 12', 'Random comments of blog post ghost busters is good.', '2012-6-30'),
  ('Went', 'Title 24', 'Random comments of blog post back when I had a life not.', '2012-5-20'),
  ('Hill', 'Title 25', 'Random comments of blog post Boston yeahhh.', '2014-1-7'),
  ('Jack', 'Title 12', 'Random comments of blog post states was good.', '2011-4-9'),
  ('Jill', 'Title 12', 'Random comments of blog post cities is good.', '2012-12-30'),
  ('Went', 'Title 28', 'Random comments of blog post whaaatttt.', '2014-12-31'),
  ('Hill', 'Title 28', 'Random comments of blog post go for it are we doing.', '2012-5-30'),
  ('Mary', 'Title 30', 'Random comments of blog post so what ???.', '2012-9-30'),
  ('Alan', 'Title 31', 'Random comments of bp disaster', '2012-4-23'),
  ('Chris', 'Title 32', 'Random comments of blog great work methods for math.', '2014-5-17'),
  ('Bryan', 'Title 33', 'Random comments of blog post 99 or so', '2013-10-30'),
  ('Tanya', 'Title 34', 'Random comments of blog post 1000 and so on', '2014-5-20'),
  ('Stevie', 'Title 36', 'Random comments of blog post car stuff is good.', '2014-2-14'),
  ('George', 'Title 36', 'Random comments of blog post what about bob was good.', '2013-12-12'),
  ('George', 'Title 38', 'Random comments of blog post go on is great.', '2014-5-1'),
  ('George', 'Title 38', 'Random comments of blog post and on and on goes boom.', '2014-11-19')
)
INSERT INTO comments
  (author_id, post_id, content, created_at)
SELECT
  users.id, posts.id, temp.content, temp.created_at::date
FROM
  users JOIN temp
    ON temp.login = users.login
    JOIN posts
      ON temp.title = posts.title;
