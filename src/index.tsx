import { Hono } from 'hono'
import { cors } from 'hono/cors'
import { serveStatic } from 'hono/cloudflare-workers'
import { renderer } from './renderer'
import { communityRoutes } from './routes/community'
import { schedulesRoutes } from './routes/schedules'
import resultsRoutes from './routes/results'

type Bindings = {
  DB: D1Database;
}

const app = new Hono<{ Bindings: Bindings }>()

// Enable CORS for API routes
app.use('/api/*', cors())

// Serve static files
app.use('/static/*', serveStatic({ root: './public' }))

// Use JSX renderer for HTML pages
app.use(renderer)

// API Routes
app.route('/api/community', communityRoutes)
app.route('/api/schedules', schedulesRoutes)
app.route('/api/results', resultsRoutes)

// Main landing page (모바일 중심, 핵심 3가지만)
app.get('/', (c) => {
  return c.render(
    <div className="min-h-screen bg-gradient-to-br from-red-50 to-blue-50">
      {/* Header */}
      <header className="bg-white shadow-sm">
        <div className="max-w-md mx-auto px-4 py-4">
          <div className="text-center">
            <h1 className="text-2xl font-bold">
              <span className="bg-gradient-to-r from-red-500 to-blue-500 bg-clip-text text-transparent">
                애슬리트 타임
              </span>
            </h1>
            <p className="text-sm text-gray-600 mt-1">한국 육상인 통합 플랫폼</p>
          </div>
        </div>
      </header>

      {/* Main Content - 핵심 3가지 기능만 */}
      <main className="max-w-md mx-auto px-4 py-8">
        <div className="space-y-6">
          
          {/* 1. 커뮤니티 */}
          <div className="bg-white rounded-xl p-6 shadow-sm border hover:shadow-md transition-shadow">
            <div className="flex items-center space-x-3 mb-4">
              <div className="w-12 h-12 bg-red-100 rounded-full flex items-center justify-center">
                <i className="fas fa-comments text-red-500 text-xl"></i>
              </div>
              <div>
                <h2 className="text-lg font-bold text-gray-900">커뮤니티</h2>
                <p className="text-sm text-gray-600">익명 게시판 · 실시간 소통</p>
              </div>
            </div>
            <div className="grid grid-cols-3 gap-2 text-xs">
              <div className="bg-gray-50 rounded px-2 py-1 text-center">초등부</div>
              <div className="bg-gray-50 rounded px-2 py-1 text-center">중등부</div>
              <div className="bg-gray-50 rounded px-2 py-1 text-center">고등부</div>
              <div className="bg-gray-50 rounded px-2 py-1 text-center">대학부</div>
              <div className="bg-gray-50 rounded px-2 py-1 text-center">실업부</div>
              <div className="bg-gray-50 rounded px-2 py-1 text-center">마스터즈</div>
            </div>
            <button className="w-full mt-4 bg-red-500 text-white py-3 rounded-lg font-semibold hover:bg-red-600 transition-colors">
              지금 바로 들어가기 →
            </button>
          </div>

          {/* 2. 경기 일정 */}
          <div className="bg-white rounded-xl p-6 shadow-sm border hover:shadow-md transition-shadow">
            <div className="flex items-center space-x-3 mb-4">
              <div className="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
                <i className="fas fa-calendar-alt text-blue-500 text-xl"></i>
              </div>
              <div>
                <h2 className="text-lg font-bold text-gray-900">경기 일정</h2>
                <p className="text-sm text-gray-600">실시간 시간표 · 대회 정보</p>
              </div>
            </div>
            <div className="text-sm text-gray-700 space-y-1">
              <div className="flex justify-between">
                <span>• 2025 춘계 중고연맹전</span>
                <span className="text-red-500">오늘</span>
              </div>
              <div className="flex justify-between">
                <span>• 전국체전 예선</span>
                <span>9/15</span>
              </div>
            </div>
            <button className="w-full mt-4 bg-blue-500 text-white py-3 rounded-lg font-semibold hover:bg-blue-600 transition-colors">
              전체 일정 보기 →
            </button>
          </div>

          {/* 3. 경기 결과 */}
          <div className="bg-white rounded-xl p-6 shadow-sm border hover:shadow-md transition-shadow">
            <div className="flex items-center space-x-3 mb-4">
              <div className="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center">
                <i className="fas fa-trophy text-green-500 text-xl"></i>
              </div>
              <div>
                <h2 className="text-lg font-bold text-gray-900">경기 결과</h2>
                <p className="text-sm text-gray-600">실시간 결과 · 기록 관리</p>
              </div>
            </div>
            <div className="text-sm text-gray-700 space-y-1">
              <div className="flex justify-between">
                <span>• 남고 100m 결승</span>
                <span className="font-mono text-green-600">10.23</span>
              </div>
              <div className="flex justify-between">
                <span>• 여중 1500m 결승</span>
                <span className="font-mono text-green-600">4:45.12</span>
              </div>
            </div>
            <button className="w-full mt-4 bg-green-500 text-white py-3 rounded-lg font-semibold hover:bg-green-600 transition-colors">
              최신 결과 확인 →
            </button>
          </div>

        </div>

        {/* Footer */}
        <div className="mt-12 text-center text-xs text-gray-500 space-y-2">
          <p>🚧 개발 중인 서비스입니다</p>
          <p>2025년 상반기 정식 런칭 예정</p>
          <p className="text-red-500 font-semibold">실제 커뮤니티가 지금 활성화되고 있습니다!</p>
        </div>
      </main>
    </div>
  )
})

export default app
