#!/bin/zsh

if [[ $(basename $(pwd)) != "docs-src" ]] {
    echo "请在 docs-src 目录下运行此脚本。"
    exit 1
}

rm -rf public/*
hugo

CURRENT_COMMIT=`git log --oneline --no-decorate -n 1`

cd public
git add .

if [ -n "$(git status --porcelain)" ]; then
    echo "Documentation changes found. Commiting the changes to the 'gh-pages' branch and pushing to origin."
    git commit -m "Update GitHub Pages documentation site to '$CURRENT_COMMIT'."
    git push github HEAD:gh-pages
else
  # No changes found, nothing to commit.
  echo "No documentation changes found."
fi

cd ..
