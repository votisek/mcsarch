echo "Adding packages..."
repo-add x86_64/mcsarch.db.tar.gz x86_64/*.pkg.tar.zst
rm x86_64/*.tar.gz.old
echo "Pushing to origin..."
git add .
git commit -m "Update packages in repo" -m "Time of update: $(date '+%Y-%m-%d %H:%M:%S')" -m "Packages added:" -m "$(git diff --name-only HEAD -- x86_64 | grep '\.pkg\.tar\.zst$' | sed 's|x86_64/||')"
git push