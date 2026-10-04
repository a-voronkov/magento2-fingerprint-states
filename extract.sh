#!/bin/bash
# Extract one tag's fingerprintable subtree set into the current work tree.
# $1 = source repo, $2 = commit, $3 = vendor tag (for the log)
set -e
REPO=$1; COMMIT=$2; TAG=$3
rm -rf ./*
# whole public trees
for p in lib/web app/design/frontend pub/errors; do
  git -C "$REPO" archive "$COMMIT" -- "$p" | tar -x
done
# module view/{frontend,base}/web subtrees (the corpus-substring rule)
git -C "$REPO" ls-tree -r --name-only "$COMMIT" -- app/code \
  | grep -E '/view/(frontend|base)/web/' \
  | grep -E '\.(js|css|map|png|jpg|jpeg|gif|svg|ico|webp|avif|woff|woff2|ttf|otf|eot|json|txt|xml|md)$' \
  | while read -r f; do
      case "$f" in
        *"/Test/"*|*"/test/"*) continue;;
      esac
      mkdir -p "$(dirname "$f")"; git -C "$REPO" cat-file blob "$COMMIT:$f" > "$f"
    done
