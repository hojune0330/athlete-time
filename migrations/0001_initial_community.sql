-- 애슬리트 타임 - 커뮤니티 초기 스키마
-- 익명 게시판 + 카테고리별 분류 시스템

-- 카테고리 테이블 (초/중/고/대/실업/마스터즈)
CREATE TABLE IF NOT EXISTS categories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  key TEXT UNIQUE NOT NULL, -- 'elementary', 'middle', 'high', 'college', 'professional', 'masters'
  label TEXT NOT NULL, -- '초등부', '중등부', '고등부', '대학부', '실업부', '마스터즈'
  description TEXT,
  sort_order INTEGER DEFAULT 0,
  active BOOLEAN DEFAULT true,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 게시글 테이블 (익명 게시판)
CREATE TABLE IF NOT EXISTS posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  category_id INTEGER NOT NULL,
  
  -- 익명 처리
  author_name TEXT, -- 닉네임 (익명일 경우 NULL)
  is_anonymous BOOLEAN DEFAULT true,
  author_ip TEXT, -- IP 해시 (관리용)
  session_token TEXT, -- 수정/삭제용 토큰
  
  -- 상태 및 메타
  status TEXT DEFAULT 'active', -- active, hidden, deleted
  is_pinned BOOLEAN DEFAULT false,
  is_hot BOOLEAN DEFAULT false,
  
  -- 통계
  view_count INTEGER DEFAULT 0,
  like_count INTEGER DEFAULT 0,
  comment_count INTEGER DEFAULT 0,
  
  -- 타임스탬프
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- 댓글 테이블
CREATE TABLE IF NOT EXISTS comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_id INTEGER NOT NULL,
  parent_id INTEGER, -- 대댓글용 (NULL이면 최상위 댓글)
  
  content TEXT NOT NULL,
  
  -- 익명 처리
  author_name TEXT, -- 닉네임 (익명일 경우 NULL)
  is_anonymous BOOLEAN DEFAULT true,
  author_ip TEXT, -- IP 해시 (관리용)
  session_token TEXT, -- 수정/삭제용 토큰
  
  -- 상태
  status TEXT DEFAULT 'active', -- active, hidden, deleted
  is_best BOOLEAN DEFAULT false, -- 베스트 댓글
  
  -- 통계
  like_count INTEGER DEFAULT 0,
  
  -- 타임스탬프
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
  FOREIGN KEY (parent_id) REFERENCES comments(id) ON DELETE CASCADE
);

-- 좋아요 테이블 (중복 방지)
CREATE TABLE IF NOT EXISTS likes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  target_type TEXT NOT NULL, -- 'post' or 'comment'
  target_id INTEGER NOT NULL,
  user_identifier TEXT NOT NULL, -- IP 해시 또는 세션 토큰
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE(target_type, target_id, user_identifier)
);

-- 인덱스 생성 (성능 최적화)
CREATE INDEX IF NOT EXISTS idx_posts_category_created ON posts(category_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_posts_status_created ON posts(status, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_posts_hot_created ON posts(is_hot, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_comments_post_created ON comments(post_id, created_at ASC);
CREATE INDEX IF NOT EXISTS idx_comments_parent ON comments(parent_id);
CREATE INDEX IF NOT EXISTS idx_likes_target ON likes(target_type, target_id);

-- 기본 카테고리 데이터 삽입
INSERT OR IGNORE INTO categories (key, label, description, sort_order) VALUES
('elementary', '초등부', '초등학교 육상선수 및 학부모', 1),
('middle', '중등부', '중학교 육상선수', 2),
('high', '고등부', '고등학교 육상선수', 3),
('college', '대학부', '대학교 육상선수', 4),
('professional', '실업부', '실업팀 및 프로 선수', 5),
('masters', '마스터즈', '마스터즈 및 동호회', 6),
('general', '자유게시판', '모든 육상인 자유 소통', 0);