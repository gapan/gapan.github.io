
create:
	rm -rf public
	mkdir public
	git worktree prune
	rm -rf .git/worktrees/public/
	git worktree add -B master public origin/master
	rm -rf public/*
	hugo

publish:
	cd public
	git add --all
	git commit -m "Publishing to master branch"
