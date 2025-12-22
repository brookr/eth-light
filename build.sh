#!/bin/bash
# Build script to create a single, minified HTML file for on-chain deployment

set -e

echo "Building single-file HTML for on-chain deployment..."

# Read the font CSS and extract the base64 data
FONT_BASE64=$(grep -o 'base64,[^)]*' tangerine.css | cut -d',' -f2)

# Read the HTML file
HTML_CONTENT=$(cat index.html)

# Create a temporary file with the font embedded inline
cat > build.html << 'EOF'
<!doctype html>
<html>
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no"/>
<title>Eth Light</title>
<style>
@font-face{font-family:"Tangerine";src:url(data:font/woff2;base64,FONT_BASE64_PLACEHOLDER) format("woff2");font-weight:400;font-style:normal;}
html,body{margin:0;height:100%;background:#050408;overflow:hidden}
body{touch-action:none}
#wrap{position:fixed;inset:0;display:flex;align-items:center;justify-content:center}
canvas{display:block;background:transparent}
</style>
</head>
<body>
<div id="wrap"><canvas id="c"></canvas></div>
<script>
EOF

# Extract just the JavaScript content (between <script> tags)
sed -n '/<script>/,/<\/script>/p' index.html | sed '1d;$d' >> build.html

# Close the HTML
cat >> build.html << 'EOF'
</script>
</body>
</html>
EOF

# Replace the font placeholder with actual base64
sed -i.bak "s|FONT_BASE64_PLACEHOLDER|$FONT_BASE64|g" build.html
rm build.html.bak

# Minify using html-minifier-terser (runs via npx, no install needed)
npx -y html-minifier-terser \
  --collapse-whitespace \
  --remove-comments \
  --minify-css true \
  --minify-js true \
  --remove-attribute-quotes \
  --remove-redundant-attributes \
  --remove-script-type-attributes \
  --remove-style-link-type-attributes \
  --use-short-doctype \
  build.html -o light.html

# Get file sizes
ORIGINAL_SIZE=$(wc -c < index.html | tr -d ' ')
FONT_SIZE=$(wc -c < tangerine.css | tr -d ' ')
BUILD_SIZE=$(wc -c < build.html | tr -d ' ')
MINIFIED_SIZE=$(wc -c < light.html | tr -d ' ')

echo ""
echo "Build complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Original HTML:        $ORIGINAL_SIZE bytes"
echo "Font CSS:             $FONT_SIZE bytes"
echo "Combined (readable):  $BUILD_SIZE bytes"
echo "Minified (on-chain):  $MINIFIED_SIZE bytes"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Files created:"
echo "  build.html  - Single file with embedded font (readable)"
echo "  light.html  - Minified version for on-chain deployment"
echo ""
