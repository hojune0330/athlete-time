// Dynamic route for individual posts
export async function onRequestGet(context) {
  const id = parseInt(context.params.id);
  
  // This would normally fetch from database
  // For now, return mock data
  return new Response(JSON.stringify({
    success: true,
    post: {
      id: id,
      title: 'Post ' + id,
      content: 'Content for post ' + id,
      views: 0
    }
  }), {
    headers: { 
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    }
  });
}

export async function onRequestPut(context) {
  // PUT /api/community/posts/:id
  const id = parseInt(context.params.id);
  const body = await context.request.json();
  
  // Update logic would go here
  return new Response(JSON.stringify({
    success: true,
    message: 'Post updated'
  }), {
    headers: { 
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    }
  });
}

export async function onRequestDelete(context) {
  // DELETE /api/community/posts/:id
  const id = parseInt(context.params.id);
  
  // Delete logic would go here
  return new Response(JSON.stringify({
    success: true,
    message: 'Post deleted'
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
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type'
    }
  });
}