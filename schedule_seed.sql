-- 애슬리트 타임 - 경기 일정 시드 데이터
-- 실제 대회와 유사한 일정 데이터

-- 대회 정보 삽입
INSERT INTO competitions (title, short_title, description, start_date, end_date, venue, venue_address, organizer, host, category, status, is_featured, participant_count, event_count) VALUES
-- 현재 진행 중인 대회
('2025 춘계 중고연맹전', '춘계 중고연맹전', '전국 중고등학교 육상 선수권 대회', '2025-09-01', '2025-09-03', '잠실종합운동장 주경기장', '서울시 송파구 올림픽로 25', '대한중고육상연맹', '서울시교육청', 'high', 'ongoing', true, 450, 24),

-- 예정된 대회들  
('제47회 전국체육대회 예선', '전국체전 예선', '각 시도별 전국체육대회 출전 선수 선발전', '2025-09-15', '2025-09-16', '인천문학경기장', '인천광역시 미추홀구 문학동', '대한체육회', '인천광역시체육회', 'general', 'scheduled', true, 320, 18),

('2025 전국실업단 선수권대회', '전국실업단대회', 'KTFL 주최 전국 실업단 대항전', '2025-09-20', '2025-09-22', '대구스타디움', '대구광역시 수성구 야구전설로 1', 'KTFL', '대구광역시청', 'professional', 'scheduled', true, 280, 22),

-- 대학 대회
('2025 추계 대학육상선수권', '추계 대학선수권', '전국 대학교 육상 선수권 대회', '2025-10-05', '2025-10-07', '목동종합운동장', '서울시 양천구 목동동로 419', '대한대학육상연맹', '서울시청', 'college', 'scheduled', false, 380, 20),

-- 마스터즈 대회
('2025 전국마스터즈대회', '전국마스터즈', '전국 마스터즈 육상 선수권 대회', '2025-10-12', '2025-10-13', '서울종합운동장 보조경기장', '서울시 송파구 잠실동', '한국마스터즈육상연맹', '서울특별시', 'masters', 'scheduled', false, 150, 16);

-- 종목 정보 삽입 (현재 진행 중인 춘계 중고연맹전)
INSERT INTO events (competition_id, name, category, gender, age_group, record_type, unit, status) VALUES
-- 트랙 종목들
(1, '남고 100m', 'track', 'male', '고등부', 'time', 'seconds', 'ongoing'),
(1, '여고 100m', 'track', 'female', '고등부', 'time', 'seconds', 'completed'),
(1, '남고 400m', 'track', 'male', '고등부', 'time', 'seconds', 'scheduled'),
(1, '여고 800m', 'track', 'female', '고등부', 'time', 'seconds', 'scheduled'),
(1, '남고 1500m', 'track', 'male', '고등부', 'time', 'seconds', 'scheduled'),
(1, '남고 110m 허들', 'track', 'male', '고등부', 'time', 'seconds', 'ongoing'),
(1, '여고 100m 허들', 'track', 'female', '고등부', 'time', 'seconds', 'scheduled'),
(1, '남고 4×100m 계주', 'track', 'male', '고등부', 'time', 'seconds', 'scheduled'),
(1, '여고 4×400m 계주', 'track', 'female', '고등부', 'time', 'seconds', 'scheduled'),

-- 필드 종목들
(1, '남고 높이뛰기', 'field', 'male', '고등부', 'height', 'meters', 'ongoing'),
(1, '여고 멀리뛰기', 'field', 'female', '고등부', 'distance', 'meters', 'scheduled'),
(1, '남고 창던지기', 'field', 'male', '고등부', 'distance', 'meters', 'scheduled'),
(1, '여고 포환던지기', 'field', 'female', '고등부', 'distance', 'meters', 'completed'),

-- 중등부 종목들
(1, '남중 100m', 'track', 'male', '중등부', 'time', 'seconds', 'completed'),
(1, '여중 1500m', 'track', 'female', '중등부', 'time', 'seconds', 'completed'),
(1, '남중 멀리뛰기', 'field', 'male', '중등부', 'distance', 'meters', 'scheduled');

-- 세부 일정 삽입 (오늘과 내일 일정)
INSERT INTO schedules (event_id, scheduled_time, round_type, round_name, participant_count, lane_count, field_location, status, is_live, notes) VALUES
-- 오늘 (9월 1일) 일정 - 진행 중/완료
(2, '2025-09-01 09:30:00', 'heat1', '예선 1조', 8, 8, 'track', 'completed', false, ''),
(2, '2025-09-01 09:45:00', 'heat2', '예선 2조', 8, 8, 'track', 'completed', false, ''),
(2, '2025-09-01 15:20:00', 'final', '결승', 8, 8, 'track', 'completed', false, '김서윤(대원외고) 11.89 우승'),

(14, '2025-09-01 10:00:00', 'heat1', '예선 1조', 6, 6, 'track', 'completed', false, ''),
(14, '2025-09-01 10:15:00', 'heat2', '예선 2조', 6, 6, 'track', 'completed', false, ''),
(14, '2025-09-01 14:30:00', 'final', '결승', 8, 8, 'track', 'completed', false, ''),

(15, '2025-09-01 11:00:00', 'heat1', '예선 1조', 8, 8, 'track', 'completed', false, ''),
(15, '2025-09-01 11:15:00', 'final', '결승', 8, 8, 'track', 'completed', false, '박민준(경기고) 4:45.12'),

(13, '2025-09-01 13:00:00', 'qualifying', '예선', 12, 0, 'field_1', 'completed', false, '이지은(수원여고) 11.45m'),

-- 현재 진행 중인 경기들 (실시간)
(1, '2025-09-01 16:00:00', 'semifinal', '준결승 1조', 8, 8, 'track', 'ongoing', true, '현재 6레인 선두'),
(1, '2025-09-01 16:15:00', 'semifinal', '준결승 2조', 8, 8, 'track', 'scheduled', false, ''),
(1, '2025-09-01 16:45:00', 'final', '결승', 8, 8, 'track', 'scheduled', false, ''),

(6, '2025-09-01 16:30:00', 'final', '결승', 8, 8, 'track', 'ongoing', true, '3조까지 완료'),
(10, '2025-09-01 15:45:00', 'final', '결승', 0, 0, 'field_2', 'ongoing', true, '현재 1.90m 진행 중'),

-- 내일 (9월 2일) 일정들
(3, '2025-09-02 09:00:00', 'heat1', '예선 1조', 8, 8, 'track', 'scheduled', false, ''),
(3, '2025-09-02 09:15:00', 'heat2', '예선 2조', 8, 8, 'track', 'scheduled', false, ''),
(3, '2025-09-02 15:00:00', 'final', '결승', 8, 8, 'track', 'scheduled', false, ''),

(4, '2025-09-02 10:30:00', 'heat1', '예선 1조', 8, 8, 'track', 'scheduled', false, ''),
(4, '2025-09-02 10:45:00', 'heat2', '예선 2조', 8, 8, 'track', 'scheduled', false, ''),
(4, '2025-09-02 14:30:00', 'final', '결승', 8, 8, 'track', 'scheduled', false, ''),

(5, '2025-09-02 11:30:00', 'heat1', '예선 1조', 10, 10, 'track', 'scheduled', false, ''),
(5, '2025-09-02 11:45:00', 'heat2', '예선 2조', 10, 10, 'track', 'scheduled', false, ''),
(5, '2025-09-02 16:20:00', 'final', '결승', 12, 12, 'track', 'scheduled', false, ''),

(7, '2025-09-02 09:30:00', 'heat1', '예선 1조', 8, 8, 'track', 'scheduled', false, ''),
(7, '2025-09-02 14:00:00', 'final', '결승', 8, 8, 'track', 'scheduled', false, ''),

(8, '2025-09-02 13:00:00', 'heat1', '예선 1조', 6, 6, 'track', 'scheduled', false, ''),
(8, '2025-09-02 17:00:00', 'final', '결승', 8, 8, 'track', 'scheduled', false, ''),

(9, '2025-09-02 17:30:00', 'final', '결승', 6, 6, 'track', 'scheduled', false, ''),

(11, '2025-09-02 10:00:00', 'qualifying', '예선', 15, 0, 'field_1', 'scheduled', false, ''),
(11, '2025-09-02 15:30:00', 'final', '결승', 8, 0, 'field_1', 'scheduled', false, ''),

(12, '2025-09-02 12:00:00', 'qualifying', '예선', 12, 0, 'field_2', 'scheduled', false, ''),
(12, '2025-09-02 16:00:00', 'final', '결승', 8, 0, 'field_2', 'scheduled', false, ''),

(16, '2025-09-02 08:30:00', 'qualifying', '예선', 10, 0, 'field_1', 'scheduled', false, '');

-- 샘플 결과 데이터 (완료된 경기들)
INSERT INTO results (schedule_id, athlete_name, athlete_number, team_name, lane_number, performance, rank, status, is_record, record_type) VALUES
-- 여고 100m 결승 결과
(3, '김서윤', '101', '대원외국어고', 4, '11.89', 1, 'OK', true, 'SB'),
(3, '박지민', '205', '경기여고', 5, '11.95', 2, 'OK', false, ''),
(3, '이하늘', '138', '서울여고', 6, '12.03', 3, 'OK', false, ''),
(3, '최유진', '067', '인천여고', 3, '12.08', 4, 'OK', false, ''),
(3, '정수빈', '192', '부산여고', 7, '12.15', 5, 'OK', false, ''),
(3, '강민서', '234', '대구여고', 2, '12.22', 6, 'OK', false, ''),
(3, '윤채영', '156', '광주여고', 8, '12.28', 7, 'OK', false, ''),
(3, '조예린', '089', '울산여고', 1, '12.35', 8, 'OK', false, ''),

-- 남중 100m 결승 결과  
(6, '박민준', '321', '경기중', 4, '11.45', 1, 'OK', true, 'SB'),
(6, '김도현', '145', '서울중', 5, '11.52', 2, 'OK', false, ''),
(6, '이준혁', '278', '부산중', 6, '11.58', 3, 'OK', false, ''),
(6, '최현우', '092', '대구중', 3, '11.63', 4, 'OK', false, ''),
(6, '정태민', '167', '인천중', 7, '11.71', 5, 'OK', false, ''),
(6, '강수호', '203', '광주중', 2, '11.78', 6, 'OK', false, ''),

-- 여중 1500m 결승 결과
(8, '이수민', '456', '서울여중', 1, '4:45.12', 1, 'OK', true, 'PB'),
(8, '박하은', '298', '경기여중', 2, '4:47.89', 2, 'OK', false, ''),
(8, '김지우', '187', '부산여중', 3, '4:52.34', 3, 'OK', false, ''),
(8, '최서연', '134', '인천여중', 4, '4:55.67', 4, 'OK', false, ''),
(8, '정유나', '245', '대구여중', 5, '4:58.12', 5, 'OK', false, ''),
(8, '강예린', '076', '광주여중', 6, '5:02.45', 6, 'OK', false, ''),

-- 여고 포환던지기 결과
(10, '이지은', '512', '수원여고', 1, '11.45', 1, 'OK', true, 'SB'),
(10, '박소영', '389', '안양여고', 2, '10.98', 2, 'OK', false, ''),
(10, '김나영', '167', '성남여고', 3, '10.76', 3, 'OK', false, ''),
(10, '최은비', '234', '용인여고', 4, '10.45', 4, 'OK', false, ''),
(10, '정미소', '456', '화성여고', 5, '10.12', 5, 'OK', false, ''),
(10, '강혜진', '123', '평택여고', 6, '9.87', 6, 'OK', false, '');