

publish:
	hugo
	cd public
	git add --all
	git commit -m "Publishing to master branch"
