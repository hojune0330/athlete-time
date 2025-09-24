import fs from 'fs/promises';
import path from 'path';

async function build() {
  console.log('🔨 Building for Cloudflare Pages...');
  
  // Create public directory
  await fs.mkdir('public', { recursive: true });
  await fs.mkdir('public/api', { recursive: true });
  
  // Copy HTML files
  const htmlFiles = [
    'index-mobile.html',
    'community-mobile.html'
  ];
  
  for (const file of htmlFiles) {
    try {
      await fs.copyFile(file, path.join('public', file));
      console.log(`✅ Copied ${file}`);
    } catch (err) {
      console.error(`❌ Failed to copy ${file}:`, err.message);
    }
  }
  
  // Create index.html that redirects to mobile
  const indexHtml = `<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="refresh" content="0; url=/index-mobile.html">
  <title>애슬리트타임 - 육상 선수들을 위한 커뮤니티</title>
</head>
<body>
  <script>window.location.replace('/index-mobile.html');</script>
  <p>페이지를 이동 중입니다...</p>
</body>
</html>`;
  
  await fs.writeFile('public/index.html', indexHtml);
  console.log('✅ Created index.html with redirect');
  
  // Create _redirects file
  const redirects = `/index-mobile /index-mobile.html 200
/community-mobile /community-mobile.html 200
/community /community-mobile.html 301
/api/* /.netlify/functions/:splat 200`;
  
  await fs.writeFile('public/_redirects', redirects);
  console.log('✅ Created _redirects file');
  
  console.log('✅ Build complete!');
}

build().catch(console.error);