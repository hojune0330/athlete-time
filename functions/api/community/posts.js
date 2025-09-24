// In-memory storage for beta period
let posts = [
  {
    id: Date.now(),
    category: '공지',
    title: '🎉 애슬리트 타임 베타 테스트 오픈',
    author: '관리자',
    content: `안녕하세요, 애슬리트 타임 커뮤니티입니다.

2025년 11월 30일까지 베타 테스트 기간입니다.
현재는 회원가입 없이 누구나 익명으로 게시물을 작성할 수 있습니다.

📌 이용 규칙:
• 게시물 작성 시 비밀번호를 설정해주세요 (수정/삭제 시 필요)
• 댓글은 자유롭게 작성 가능합니다
• 부적절한 댓글은 10명 이상 신고 시 자동 블라인드 처리됩니다
• 베타 기간 후 정식 서비스는 회원제로 운영됩니다

건전한 육상 커뮤니티 문화를 만들어주세요!`,
    date: new Date().toISOString(),
    views: 0,
    likes: [],
    dislikes: [],
    comments: [],
    isNotice: true,
    isAdmin: true,
    reports: [],
    password: 'admin',
    isBlinded: false
  }
];

export async function onRequestGet(context) {
  // GET /api/community/posts
  return new Response(JSON.stringify({ 
    success: true, 
    posts: posts.filter(p => !p.isBlinded || p.isAdmin)
  }), {
    headers: { 
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    }
  });
}

export async function onRequestPost(context) {
  // POST /api/community/posts
  try {
    const body = await context.request.json();
    const newPost = {
      id: Date.now(),
      category: body.category || '자유',
      title: body.title,
      author: body.author || '익명',
      content: body.content,
      password: body.password || '',
      date: new Date().toISOString(),
      views: 0,
      likes: [],
      dislikes: [],
      comments: [],
      isNotice: false,
      isAdmin: false,
      reports: [],
      isBlinded: false
    };
    
    posts.unshift(newPost);
    
    return new Response(JSON.stringify({ 
      success: true, 
      post: newPost 
    }), {
      headers: { 
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    });
  } catch (error) {
    return new Response(JSON.stringify({ 
      success: false, 
      error: error.message 
    }), {
      status: 400,
      headers: { 
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      }
    });
  }
}

export async function onRequestOptions(context) {
  // Handle CORS preflight
  return new Response(null, {
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type'
    }
  });
}