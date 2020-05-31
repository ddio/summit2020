#!/bin/bash -x

# Specify the development branch and stable branch names
FROM_BRANCH="master"
TO_BRANCH="production"

# PUSH_URL="https://$GITHUB_TOKEN@github.com:g0v/summit2020.git"
PUSH_URL="https://$GITHUB_TOKEN@github.com:ddio/summit2020.gita"

# Checkout the dev branch
#git checkout $FROM_BRANCH && \
#echo "Checking out $TO_BRANCH..." && \

# Checkout the latest stable
git fetch origin $TO_BRANCH:$TO_BRANCH && \
git checkout $TO_BRANCH && \

# Merge the dev into latest stable
echo "Merging mater to production" && \
git merge $FROM_BRANCH --no-commit && \
git commit -m "release $TRAVIS_TAG" --author="Summit Bot <bot@summit.g0v.tw>" && \

# Push changes back to remote vcs
echo "Push release $TRAVIS_TAG" && \
git push $PUSH_URL && \
echo "Merge complete!" || \
echo "Error Occurred. Merge failed"
