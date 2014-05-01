DROP DATABASE IF EXISTS blog;
CREATE DATABASE blog;
\c blog

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

CREATE INDEX ON categories (name);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  login TEXT UNIQUE NOT NULL,
  password TEXT,
  created_at DATE DEFAULT current_timestamp
);

CREATE INDEX ON users (login);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  created_at DATE,
  author_id INTEGER REFERENCES users,
  category_id INTEGER REFERENCES categories
);

CREATE INDEX ON posts (author_id);
CREATE INDEX ON posts (category_id);
CREATE INDEX ON posts (title);
CREATE INDEX ON posts (created_at);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content TEXT NOT NULL,
  created_at DATE,
  author_id INTEGER REFERENCES users,
  post_id INTEGER REFERENCES posts
);

CREATE INDEX ON comments (author_id);
CREATE INDEX ON comments (post_id);
CREATE INDEX ON comments (created_at);
