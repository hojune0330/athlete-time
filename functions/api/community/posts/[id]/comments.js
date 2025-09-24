// Comments endpoint
export async function onRequestPost(context) {
  const postId = parseInt(context.params.id);
  const body = await context.request.json();
  
  const newComment = {
    id: Date.now(),
    postId: postId,
    author: body.author || '익명',
    content: body.content,
    date: new Date().toISOString(),
    reports: [],
    isBlinded: false
  };
  
  return new Response(JSON.stringify({
    success: true,
    comment: newComment
  }), {
    headers: { 
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    }
  });
}

export async function onRequestOptions(context) {
  return new Response(null, {
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type'
    }
  });
}