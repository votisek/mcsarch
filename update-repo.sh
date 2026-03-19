#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${1:-.}"
cd "$REPO_DIR"

if [[ ! -d x86_64 ]]; then
  echo "Error: x86_64 directory not found in $(pwd)"
  echo "Run this script in the root of your repo branch checkout (or pass path as arg)."
  exit 1
fi

shopt -s nullglob
packages=(x86_64/*.pkg.tar.zst)

if (( ${#packages[@]} == 0 )); then
  echo "No packages found in x86_64/*.pkg.tar.zst"
  exit 1
fi

echo "Adding packages..."
repo-add x86_64/mcsarch.db.tar.gz "${packages[@]}"
rm -f x86_64/*.tar.gz.old

rm -f x86_64/mcsarch.db x86_64/mcsarch.files
cp -f x86_64/mcsarch.db.tar.gz x86_64/mcsarch.db
cp -f x86_64/mcsarch.files.tar.gz x86_64/mcsarch.files

echo "Staging changes..."
git add x86_64/

if git diff --cached --quiet; then
  echo "No changes to commit."
  exit 0
fi

packages_added="$(git diff --cached --name-only -- x86_64 | grep '\.pkg\.tar\.zst$' | sed 's|x86_64/||' || true)"

echo "Committing..."
if [[ -n "$packages_added" ]]; then
  git commit \
    -m "Update packages in repo" \
    -m "Time of update: $(date '+%Y-%m-%d %H:%M:%S')" \
    -m "Packages added:" \
    -m "$packages_added"
else
  git commit \
    -m "Update packages in repo" \
    -m "Time of update: $(date '+%Y-%m-%d %H:%M:%S')"
fi

echo "Pushing to origin..."
git push
echo "Done."
