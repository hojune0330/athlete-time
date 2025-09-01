-- 애슬리트 타임 - 경기 일정 및 시간표 시스템
-- 대회 > 종목 > 세부 일정 구조

-- 대회 테이블 (competition)
CREATE TABLE IF NOT EXISTS competitions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL, -- '제36회 KTFL 전국실업단대항육상경기대회'
  short_title TEXT, -- 'KTFL 전국실업단'
  description TEXT,
  
  -- 날짜 정보
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  
  -- 장소 정보
  venue TEXT NOT NULL, -- '잠실종합운동장 주경기장'
  venue_address TEXT,
  
  -- 조직 정보
  organizer TEXT, -- '대한육상연맹'
  host TEXT, -- '서울시체육회'
  
  -- 카테고리
  category TEXT NOT NULL, -- 'elementary', 'middle', 'high', 'college', 'professional', 'masters'
  
  -- 상태
  status TEXT DEFAULT 'scheduled', -- scheduled, ongoing, completed, cancelled
  is_featured BOOLEAN DEFAULT false,
  
  -- 메타 정보
  participant_count INTEGER DEFAULT 0,
  event_count INTEGER DEFAULT 0,
  
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 종목 테이블 (events)
CREATE TABLE IF NOT EXISTS events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  competition_id INTEGER NOT NULL,
  
  -- 종목 정보
  name TEXT NOT NULL, -- '남자 100m', '여자 800m', '남자 높이뛰기'
  category TEXT NOT NULL, -- 'track' or 'field'
  gender TEXT NOT NULL, -- 'male', 'female', 'mixed'
  age_group TEXT, -- '고등부', '대학부', '일반부'
  
  -- 기록 형태
  record_type TEXT DEFAULT 'time', -- 'time', 'distance', 'height', 'points'
  unit TEXT DEFAULT 'seconds', -- 'seconds', 'meters', 'points'
  
  -- 상태
  status TEXT DEFAULT 'scheduled', -- scheduled, ongoing, completed, cancelled
  
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (competition_id) REFERENCES competitions(id) ON DELETE CASCADE
);

-- 세부 일정 테이블 (schedules)
CREATE TABLE IF NOT EXISTS schedules (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  event_id INTEGER NOT NULL,
  
  -- 시간 정보
  scheduled_time DATETIME NOT NULL,
  actual_time DATETIME, -- 실제 시작 시간 (지연 등)
  
  -- 라운드 정보
  round_type TEXT NOT NULL, -- 'qualifying', 'semifinal', 'final', 'heat1', 'heat2'
  round_name TEXT, -- '예선', '준결승', '결승', '1조', '2조'
  
  -- 참가 정보
  participant_count INTEGER DEFAULT 0,
  lane_count INTEGER DEFAULT 8,
  
  -- 위치 정보  
  field_location TEXT, -- 'track', 'field_1', 'field_2', 'warm_up_track'
  
  -- 상태
  status TEXT DEFAULT 'scheduled', -- scheduled, ongoing, completed, cancelled, delayed
  
  -- 실시간 편집 지원
  notes TEXT, -- 관리자 메모
  is_live BOOLEAN DEFAULT false,
  
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);

-- 경기 결과 테이블 (기본 구조)
CREATE TABLE IF NOT EXISTS results (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  schedule_id INTEGER NOT NULL,
  
  -- 참가자 정보
  athlete_name TEXT NOT NULL,
  athlete_number TEXT, -- 등번호
  team_name TEXT,
  lane_number INTEGER,
  
  -- 기록
  performance TEXT, -- '10.23', '15.45m', '2.10m'
  rank INTEGER,
  
  -- 상태 및 특이사항
  status TEXT DEFAULT 'OK', -- OK, DNS, DNF, DQ, NM
  is_record BOOLEAN DEFAULT false, -- PB, SB, NR, WR 등
  record_type TEXT, -- 'PB', 'SB', 'NR', 'WR', 'MR'
  
  -- 추가 정보
  reaction_time REAL, -- 출발 반응 시간
  wind_speed REAL, -- 풍속
  
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (schedule_id) REFERENCES schedules(id) ON DELETE CASCADE
);

-- 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_competitions_date ON competitions(start_date, end_date);
CREATE INDEX IF NOT EXISTS idx_competitions_category ON competitions(category, status);
CREATE INDEX IF NOT EXISTS idx_competitions_status ON competitions(status, is_featured);

CREATE INDEX IF NOT EXISTS idx_events_competition ON events(competition_id);
CREATE INDEX IF NOT EXISTS idx_events_category ON events(category, gender);

CREATE INDEX IF NOT EXISTS idx_schedules_event ON schedules(event_id);
CREATE INDEX IF NOT EXISTS idx_schedules_time ON schedules(scheduled_time);
CREATE INDEX IF NOT EXISTS idx_schedules_status ON schedules(status, is_live);

CREATE INDEX IF NOT EXISTS idx_results_schedule ON results(schedule_id);
CREATE INDEX IF NOT EXISTS idx_results_rank ON results(rank);