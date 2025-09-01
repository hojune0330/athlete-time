-- Results and Records Management Schema

-- 개인 최고 기록 관리 테이블
CREATE TABLE IF NOT EXISTS personal_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  athlete_name TEXT NOT NULL,
  school_team TEXT,  -- 소속 학교/팀
  category TEXT NOT NULL,  -- 초등부, 중등부, 고등부, 대학부, 실업부, 마스터즈
  age_group TEXT,  -- 구체적 연령대 (중1, 고2, 대1 등)
  event_name TEXT NOT NULL,  -- 종목명 (100m, 200m, 1500m, 높이뛰기 등)
  event_type TEXT NOT NULL,  -- 'track' 또는 'field'
  record_value TEXT NOT NULL,  -- 기록 (11.50초, 1.95m, 15.20m 등)
  record_numeric REAL,  -- 정렬용 숫자 값 (초 단위 또는 미터 단위)
  competition_name TEXT,  -- 기록 달성 대회명
  record_date DATE,  -- 기록 달성 날짜
  wind_speed TEXT,  -- 바람 속도 (단거리용)
  is_verified BOOLEAN DEFAULT false,  -- 공식 인증 여부
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 경기 결과 상세 기록 테이블
CREATE TABLE IF NOT EXISTS competition_results (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  schedule_id INTEGER NOT NULL,  -- schedules 테이블 참조
  event_name TEXT NOT NULL,
  round_name TEXT,  -- 예선, 준결승, 결승
  lane_position INTEGER,  -- 레이n번 또는 시도 순서
  athlete_name TEXT NOT NULL,
  school_team TEXT,
  grade_age TEXT,  -- 학년/나이
  result_value TEXT,  -- 기록 (11.50초, DNS, DNF 등)
  result_numeric REAL,  -- 정렬용 숫자 값
  rank_position INTEGER,  -- 순위
  wind_speed TEXT,  -- 바람 속도
  is_record BOOLEAN DEFAULT false,  -- 신기록 여부
  record_type TEXT,  -- 대회신기록, 개인최고기록 등
  notes TEXT,  -- 비고사항
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (schedule_id) REFERENCES schedules(id)
);

-- 대회별 메달 집계 테이블
CREATE TABLE IF NOT EXISTS medal_counts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  competition_id INTEGER NOT NULL,
  school_team TEXT NOT NULL,
  category TEXT NOT NULL,  -- 초등부, 중등부 등
  gold_count INTEGER DEFAULT 0,
  silver_count INTEGER DEFAULT 0,
  bronze_count INTEGER DEFAULT 0,
  total_points INTEGER DEFAULT 0,  -- 점수제일 경우
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (competition_id) REFERENCES competitions(id)
);

-- 실시간 기록 업데이트 로그 테이블
CREATE TABLE IF NOT EXISTS result_updates (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  schedule_id INTEGER NOT NULL,
  update_type TEXT NOT NULL,  -- 'result_add', 'ranking_update', 'record_break'
  update_content TEXT NOT NULL,  -- 업데이트 내용
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (schedule_id) REFERENCES schedules(id)
);

-- 인덱스 생성
CREATE INDEX IF NOT EXISTS idx_personal_records_athlete ON personal_records(athlete_name);
CREATE INDEX IF NOT EXISTS idx_personal_records_event ON personal_records(event_name, category);
CREATE INDEX IF NOT EXISTS idx_personal_records_school ON personal_records(school_team, category);
CREATE INDEX IF NOT EXISTS idx_personal_records_numeric ON personal_records(event_name, record_numeric);

CREATE INDEX IF NOT EXISTS idx_competition_results_schedule ON competition_results(schedule_id);
CREATE INDEX IF NOT EXISTS idx_competition_results_athlete ON competition_results(athlete_name);
CREATE INDEX IF NOT EXISTS idx_competition_results_rank ON competition_results(rank_position);

CREATE INDEX IF NOT EXISTS idx_medal_counts_competition ON medal_counts(competition_id);
CREATE INDEX IF NOT EXISTS idx_medal_counts_school ON medal_counts(school_team, category);

CREATE INDEX IF NOT EXISTS idx_result_updates_schedule ON result_updates(schedule_id);
CREATE INDEX IF NOT EXISTS idx_result_updates_timestamp ON result_updates(timestamp);