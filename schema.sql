-- 게시물 테이블
CREATE TABLE IF NOT EXISTS posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  category TEXT NOT NULL,
  title TEXT NOT NULL,
  author TEXT NOT NULL,
  content TEXT NOT NULL,
  password TEXT,
  date DATETIME DEFAULT CURRENT_TIMESTAMP,
  views INTEGER DEFAULT 0,
  is_notice BOOLEAN DEFAULT 0,
  is_admin BOOLEAN DEFAULT 0,
  is_blinded BOOLEAN DEFAULT 0
);

-- 댓글 테이블
CREATE TABLE IF NOT EXISTS comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_id INTEGER NOT NULL,
  author TEXT NOT NULL,
  content TEXT NOT NULL,
  date DATETIME DEFAULT CURRENT_TIMESTAMP,
  is_blinded BOOLEAN DEFAULT 0,
  FOREIGN KEY (post_id) REFERENCES posts(id)
);

-- 투표 테이블
CREATE TABLE IF NOT EXISTS votes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_id INTEGER NOT NULL,
  user_id TEXT NOT NULL,
  vote_type TEXT NOT NULL, -- 'like' or 'dislike'
  date DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(post_id, user_id),
  FOREIGN KEY (post_id) REFERENCES posts(id)
);

-- 신고 테이블
CREATE TABLE IF NOT EXISTS reports (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  target_type TEXT NOT NULL, -- 'post' or 'comment'
  target_id INTEGER NOT NULL,
  user_id TEXT NOT NULL,
  reason TEXT,
  date DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(target_type, target_id, user_id)
);

-- 인덱스 생성
CREATE INDEX idx_posts_date ON posts(date DESC);
CREATE INDEX idx_posts_category ON posts(category);
CREATE INDEX idx_comments_post ON comments(post_id);
CREATE INDEX idx_votes_post ON votes(post_id);
CREATE INDEX idx_reports_target ON reports(target_type, target_id);
