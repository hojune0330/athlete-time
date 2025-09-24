// Cloudflare Pages Functions middleware
export async function onRequest(context) {
  const url = new URL(context.request.url);
  
  // Skip API routes
  if (url.pathname.startsWith('/api/')) {
    return context.next();
  }
  
  // Skip static files
  if (url.pathname.endsWith('.html') || 
      url.pathname.endsWith('.css') || 
      url.pathname.endsWith('.js') ||
      url.pathname.endsWith('.png') ||
      url.pathname.endsWith('.jpg') ||
      url.pathname.endsWith('.ico')) {
    return context.next();
  }
  
  // Let worker handle other routes
  return context.next();
}