import { Hono } from 'hono'
import { cors } from 'hono/cors'
import { serveStatic } from 'hono/cloudflare-workers'
import { renderer } from './renderer'
import { StaticApp } from './components/StaticApp'
// Temporary: Comment out database-dependent routes for production deployment
// import { communityRoutes } from './routes/community'
// import { schedulesRoutes } from './routes/schedules'
// import resultsRoutes from './routes/results'

// Temporary: Comment out database bindings for production deployment
// type Bindings = {
//   DB: D1Database;
// }

const app = new Hono()

// Enable CORS for API routes
app.use('/api/*', cors())

// Serve static files
app.use('/static/*', serveStatic({ root: './public' }))

// Use JSX renderer for HTML pages
app.use(renderer)

// Temporary API routes (without database)
app.get('/api/community/categories', (c) => {
  return c.json({
    success: true,
    categories: [
      { id: 1, name: '초등부', description: '초등학생 육상인들의 공간' },
      { id: 2, name: '중등부', description: '중학생 육상인들의 공간' },
      { id: 3, name: '고등부', description: '고등학생 육상인들의 공간' },
      { id: 4, name: '대학부', description: '대학생 육상인들의 공간' },
      { id: 5, name: '실업부', description: '실업팀 육상인들의 공간' },
      { id: 6, name: '마스터즈', description: '마스터즈 육상인들의 공간' },
      { id: 7, name: '자유게시판', description: '자유로운 소통 공간' }
    ]
  })
})

app.get('/api/results/rankings/:eventName', (c) => {
  const eventName = c.req.param('eventName')
  return c.json({
    success: true,
    event_name: eventName,
    message: '데이터베이스 연결 준비 중입니다. 곧 실제 기록이 표시됩니다!'
  })
})

// API Routes (commented out for production deployment)
// app.route('/api/community', communityRoutes)
// app.route('/api/schedules', schedulesRoutes)  
// app.route('/api/results', resultsRoutes)

// Main landing page - Static JSX App with Client-side Interactions
app.get('/', (c) => {
  return c.render(<StaticApp />)
})

export default app
