-- Example SQL file to showcase Solarized Light theme syntax highlighting
-- This demonstrates various SQL constructs and their colors

-- Create tables
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE posts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    views INTEGER DEFAULT 0,
    published_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE comments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Insert sample data
INSERT INTO users (username, email) VALUES 
    ('alice', 'alice@example.com'),
    ('bob', 'bob@example.com'),
    ('charlie', 'charlie@example.com');

INSERT INTO posts (user_id, title, content, views) VALUES
    (1, 'First Post', 'This is my first post!', 42),
    (1, 'SQL Tips', 'Here are some SQL optimization tips', 128),
    (2, 'Hello World', 'My introduction to the community', 56);

-- Basic SELECT queries
SELECT * FROM users;

SELECT username, email 
FROM users 
WHERE is_active = TRUE;

-- JOIN queries
SELECT 
    u.username,
    p.title,
    p.views,
    p.published_at
FROM users u
INNER JOIN posts p ON u.id = p.user_id
WHERE p.views > 50
ORDER BY p.views DESC
LIMIT 10;

-- Aggregate functions
SELECT 
    user_id,
    COUNT(*) as post_count,
    SUM(views) as total_views,
    AVG(views) as avg_views,
    MAX(views) as max_views
FROM posts
GROUP BY user_id
HAVING COUNT(*) > 1;

-- Subquery example
SELECT username, email
FROM users
WHERE id IN (
    SELECT DISTINCT user_id 
    FROM posts 
    WHERE views > 100
);

-- UPDATE statement
UPDATE posts
SET views = views + 1,
    published_at = CURRENT_TIMESTAMP
WHERE id = 1;

-- DELETE statement
DELETE FROM comments
WHERE created_at < DATE('now', '-30 days');

-- Complex query with multiple JOINs
SELECT 
    u.username,
    p.title,
    COUNT(c.id) as comment_count,
    MAX(c.created_at) as last_comment
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
LEFT JOIN comments c ON p.id = c.post_id
GROUP BY u.id, p.id
ORDER BY comment_count DESC;

-- Window functions
SELECT 
    username,
    title,
    views,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY views DESC) as rank
FROM users u
JOIN posts p ON u.id = p.user_id;

-- CTE (Common Table Expression)
WITH popular_posts AS (
    SELECT id, user_id, title, views
    FROM posts
    WHERE views > 75
)
SELECT u.username, pp.title, pp.views
FROM popular_posts pp
JOIN users u ON pp.user_id = u.id;

-- Create index
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_views ON posts(views DESC);

-- Create view
CREATE VIEW user_stats AS
SELECT 
    u.id,
    u.username,
    COUNT(p.id) as total_posts,
    COALESCE(SUM(p.views), 0) as total_views
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
GROUP BY u.id;
