-- 애슬리트 타임 데모 데이터
-- 실제 활성 커뮤니티 느낌을 위한 샘플 게시글과 댓글

-- 샘플 게시글들 (호준님이 말한 흥미로운 내용들)
INSERT INTO posts (title, content, category_id, is_anonymous, author_name, view_count, like_count, comment_count, is_hot, created_at) VALUES
-- 고등부 게시글들
('서울고 800m 김형식 오빠 여자친구 있나요?', '저희 학교 김형식 오빠가 너무 잘생겼는데... 혹시 여자친구 있는지 아시는 분?? 🥺', 3, true, NULL, 127, 8, 12, true, datetime('now', '-2 hours')),

('내일 전국체전 예선 긴장돼죽겠어요 ㅠㅠ', '고3인데 마지막 기회에요... 100m 11초대 목표인데 가능할까요? 응원해주세요!!', 3, true, NULL, 89, 15, 8, false, datetime('now', '-4 hours')),

('우리학교 육상부 선배들 왜 이렇게 잘생겼지', '진짜 육상 하는 남자들 몸매가 다르긴 하구나... 특히 400m 하는 선배 💕', 3, true, NULL, 156, 23, 19, true, datetime('now', '-6 hours')),

-- 중등부 게시글들  
('중2인데 1500m 4분 40초 어떤가요?', '처음 기록재서 4:40 나왔는데 나중에 더 줄어들까요? 목표는 4분 20초대에요!', 2, false, '중거리러너', 67, 12, 6, false, datetime('now', '-8 hours')),

('체육관에서 연습하는데 너무 더워요 ㅜㅜ', '에어컨도 안 켜주고... 코치님이 정신력이라고 하시는데 진짜 힘들어요', 2, true, NULL, 45, 7, 4, false, datetime('now', '-12 hours')),

-- 대학부 게시글들
('대학 입학 후 기록 늘었나요?', '고등학교 때보다 체계적인 훈련 받으니까 확실히 다르네요. 다들 어떠세요?', 4, false, '체대생', 92, 18, 11, false, datetime('now', '-1 day')),

('전국대학선수권 D-7', '떨린다... 이번에 꼭 입상하고 싶어요. 같이 나가는 선수들 화이팅!', 4, true, NULL, 134, 25, 14, true, datetime('now', '-1 day')),

-- 실업부 게시글들
('신인 선수 적응 팁 있나요?', '프로팀에 들어온 지 3개월 됐는데 아직도 어색해요... 선배들이 무서워요 ㅠㅠ', 5, true, NULL, 78, 9, 7, false, datetime('now', '-18 hours')),

('올해 아시안게임 목표', '개인 최고 기록 갱신이 목표입니다. 응원 많이 해주세요!', 5, false, '허들러', 203, 45, 23, true, datetime('now', '-2 days')),

-- 마스터즈 게시글들
('50대에 육상 시작했는데요', '늦은 나이에 시작해서 걱정이 많았는데, 생각보다 재밌네요! 같은 또래 분들 계시나요?', 6, false, '늦깎이러너', 112, 28, 16, false, datetime('now', '-1 day')),

-- 자유게시판
('육상화 추천해주세요', '스파이크 새로 사려고 하는데 어떤 브랜드가 좋을까요? 예산은 15만원 정도에요', 7, true, NULL, 189, 31, 22, true, datetime('now', '-3 hours')),

('대회 사진 찍어주는 분 계신가요?', '부모님이 못 오셔서... 혹시 대회 때 사진 찍어주실 분 있으실까요? ㅠㅠ', 7, true, NULL, 67, 12, 8, false, datetime('now', '-5 hours'));

-- 댓글들 (위 게시글에 대한 실제적인 반응들)
INSERT INTO comments (post_id, content, is_anonymous, author_name, like_count, is_best, created_at) VALUES
-- 김형식 오빠 게시글 댓글들
(1, '김형식 오빠 청화여고 김은혜 언니와 사귀는 걸로 알고 있어요. 조심하세요~ 😅', true, NULL, 5, true, datetime('now', '-1.5 hours')),
(1, '어 저도 그 소문 들었어요! 헤어졌다가 다시 만나는 걸로...', true, NULL, 3, false, datetime('now', '-1 hour')),
(1, '오빠 인스타 팔로우는 해봤어요? ㅋㅋ', true, NULL, 2, false, datetime('now', '-45 minutes')),

-- 전국체전 예선 게시글 댓글들
(2, '화이팅!! 긴장하지 말고 평소 연습한 대로만 하세요!', false, '선배러너', 8, true, datetime('now', '-3 hours')),
(2, '11초대 충분히 가능해요! 몸 관리 잘하고 컨디션만 끌어올리세요', false, '코치님', 6, false, datetime('now', '-2.5 hours')),
(2, '저도 내일 같은 대회 나가요~ 같이 화이팅해요!', true, NULL, 4, false, datetime('now', '-2 hours')),

-- 잘생긴 선배들 게시글 댓글들
(3, 'ㅋㅋㅋ 인정! 우리 학교도 육상부가 비주얼 담당이에요', true, NULL, 12, false, datetime('now', '-5 hours')),
(3, '400m 하는 선배 누구에요?? 저도 궁금해요 ㅎㅎ', true, NULL, 8, false, datetime('now', '-4 hours')),
(3, '육상 남자들 어깨 진짜... 💪', true, NULL, 15, true, datetime('now', '-3 hours')),

-- 1500m 기록 게시글 댓글들
(4, '중2에 4:40이면 정말 좋은 기록이에요! 꾸준히 하면 4:20도 가능해요', false, '중거리코치', 9, true, datetime('now', '-7 hours')),
(4, '와 대박! 저는 중3인데 아직 5분도 못 끊었어요 ㅠㅠ', true, NULL, 4, false, datetime('now', '-6 hours')),

-- 더운 체육관 게시글 댓글들
(5, '여름 훈련이 제일 힘들죠 ㅠㅠ 그래도 견디면 가을에 기록 나와요!', true, NULL, 3, false, datetime('now', '-11 hours')),
(5, '물 많이 드세요~ 탈수 조심하시고', false, '선배', 5, true, datetime('now', '-10 hours')),

-- 육상화 추천 게시글 댓글들
(11, '나이키 줌X 추천해요! 15만원이면 충분히 살 수 있어요', false, '장비러버', 12, true, datetime('now', '-2 hours')),
(11, '아식스도 좋아요~ 발볼 넓으시면 아식스가 편해요', true, NULL, 8, false, datetime('now', '-1.5 hours')),
(11, '중고로 사는 것도 방법이에요. 상태 좋은 거 많아요!', true, NULL, 6, false, datetime('now', '-1 hour'));

-- 실제 활성도를 위해 좋아요 데이터도 추가
INSERT INTO likes (target_type, target_id, user_identifier) VALUES
('post', 1, 'user1'), ('post', 1, 'user2'), ('post', 1, 'user3'), ('post', 1, 'user4'),
('post', 3, 'user1'), ('post', 3, 'user5'), ('post', 3, 'user6'), ('post', 3, 'user7'), ('post', 3, 'user8'),
('post', 7, 'user2'), ('post', 7, 'user3'), ('post', 7, 'user9'), ('post', 7, 'user10'),
('post', 9, 'user4'), ('post', 9, 'user5'), ('post', 9, 'user11'), ('post', 9, 'user12'),
('post', 11, 'user1'), ('post', 11, 'user6'), ('post', 11, 'user7'), ('post', 11, 'user13'),
('comment', 1, 'user2'), ('comment', 1, 'user3'), ('comment', 1, 'user8'),
('comment', 4, 'user1'), ('comment', 4, 'user5'), ('comment', 4, 'user9'), ('comment', 4, 'user14'),
('comment', 9, 'user3'), ('comment', 9, 'user7'), ('comment', 9, 'user10'), ('comment', 9, 'user15');