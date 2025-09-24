# 🚀 애슬리트타임 배포 가이드

## 📋 체크리스트
- [ ] Cloudflare 계정 생성
- [ ] GitHub 연결
- [ ] Pages 프로젝트 생성
- [ ] 배포 완료

## Step 1: Cloudflare 계정
1. https://dash.cloudflare.com 접속
2. Sign Up (회원가입)
3. 이메일 인증

## Step 2: Pages 프로젝트 만들기
1. 로그인 후 왼쪽 메뉴에서 "Workers & Pages" 클릭
2. "Create application" 버튼 클릭
3. "Pages" 탭 선택
4. "Connect to Git" 클릭

## Step 3: GitHub 연결
1. "Connect GitHub account" 클릭
2. GitHub 로그인
3. "Authorize Cloudflare Pages" 승인
4. Repository 검색창에 "athletetime" 입력
5. "athlete-time" 선택

## Step 4: 빌드 설정
프로젝트 이름: athletetime
Production branch: main
Build command: npm run build
Build output directory: dist

## Step 5: 배포
1. "Save and Deploy" 클릭
2. 2-3분 대기
3. 완료!

## 📌 배포 후 URL
https://athletetime.pages.dev

## 문제 발생 시
- 빌드 실패: package.json 확인
- 404 에러: dist 폴더 확인
- 느린 속도: 정상 (첫 배포는 느림)