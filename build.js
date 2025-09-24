import { exec } from 'child_process';
import { promisify } from 'util';
import fs from 'fs/promises';
import path from 'path';

const execAsync = promisify(exec);

async function build() {
  console.log('🔨 Building Vite project...');
  await execAsync('vite build');
  
  console.log('📁 Copying static files...');
  
  // Copy mobile HTML files
  const filesToCopy = [
    'index-mobile.html',
    'community-mobile.html'
  ];
  
  for (const file of filesToCopy) {
    try {
      await fs.copyFile(
        path.join(process.cwd(), file),
        path.join(process.cwd(), 'dist', file)
      );
      console.log(`✅ Copied ${file}`);
    } catch (err) {
      console.error(`❌ Failed to copy ${file}:`, err.message);
    }
  }
  
  // Create _routes.json for Cloudflare Pages
  const routes = {
    version: 1,
    include: ["/*"],
    exclude: [
      "/index-mobile.html",
      "/community-mobile.html",
      "/static/*",
      "/*.css",
      "/*.js",
      "/*.png",
      "/*.jpg",
      "/*.ico"
    ]
  };
  
  await fs.writeFile(
    path.join(process.cwd(), 'dist', '_routes.json'),
    JSON.stringify(routes, null, 2)
  );
  
  console.log('✅ Build complete!');
}

build().catch(console.error);