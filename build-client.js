// Client bundle builder
import { build } from 'esbuild'
import fs from 'fs'

// Create the client bundle
build({
  entryPoints: ['src/components/InteractiveAppV2.tsx'],
  bundle: true,
  minify: true,
  format: 'iife',
  globalName: 'AthletimeApp',
  outfile: 'public/static/bundle.js',
  loader: {
    '.tsx': 'tsx',
    '.ts': 'ts',
  },
  define: {
    'process.env.NODE_ENV': '"production"'
  },
  external: ['react', 'react-dom']
}).then(() => {
  console.log('Client bundle created!')
  
  // Also create a wrapper
  const wrapper = `
    window.AthletimeApp = function() {
      return React.createElement('div', { className: 'p-8 text-center' },
        React.createElement('h1', { className: 'text-2xl font-bold mb-4' }, 'アプリ読み込み中...')
      );
    };
  `;
  
  fs.writeFileSync('public/static/app.js', wrapper);
}).catch(err => {
  console.error('Build failed:', err)
})