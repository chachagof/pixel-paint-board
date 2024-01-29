set -e

# build
npm run build
cd dist
git init
git add .
git commit -m 'deploy'
git push -f https://github.com/chachagof/pixel-paint-board.git main:gh-pages

cd -