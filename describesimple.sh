#!/bin/sh

# Check for git and a git repo.
if head=`git rev-parse --verify HEAD 2>/dev/null`; then
	comm=`git log --pretty=oneline -n1 ../mini | awk ' { print $1 }'`
	if tagver=`git describe --exact-match --match bootmii-\* $comm 2>/dev/null`; then
		printf "%s" "BootMii v"`printf "%s" $tagver | awk '{ sub (/bootmii-/, ""); print;}'`
	else
		printf "%s" ""`printf "%s" \`git describe --abbrev=4 --match bootmii-\* $comm | awk '{ sub (/bootmii-/, ""); print;}'\``
	fi

	# Are there uncommitted changes?
	git update-index --refresh --unmerged > /dev/null
	git diff-index --quiet HEAD ../mini || printf "%s" '*'
fi

echo