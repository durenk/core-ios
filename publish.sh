#!/usr/bin/env bash

if [ -z "$1" ]
    then
    echo "No increment type supplied, should be [major/minor/patch]"
    exit 1
fi

if [ $1 != "major" ] && [ $1 != "minor" ] && [ $1 != "patch" ]
    then
    echo "Invalid increment type supplied, should be [major/minor/patch]"
    exit 1
fi

if [ -z "$2" ]
    then
    echo "No commit message supplied"
    exit 1
fi

pod lib lint --allow-warnings
podspec-bump $1 -w
git add .
git commit -m "'$2'"
git push
git tag "`podspec-bump --dump-version`"
git push --tags
pod repo push cocoapod-specs OLCore.podspec --allow-warnings
