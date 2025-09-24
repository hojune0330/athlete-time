#!/bin/sh
# Copy static HTML files to dist directory
cp index-mobile.html dist/ 2>/dev/null || echo "Warning: index-mobile.html not copied"
cp community-mobile.html dist/ 2>/dev/null || echo "Warning: community-mobile.html not copied"
cp _redirects dist/ 2>/dev/null || echo "Warning: _redirects not copied"
echo "Static files copy completed"