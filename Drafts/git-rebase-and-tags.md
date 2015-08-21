Title: Git rebase and Tags
Autor: Mateusz Świetlicki
CreateDate: 2015-06-02 12:46
Tags: 	Blog
		EN
		Git

In big project I'm working on we mark project version by creating git tag with name "v1.43.0.2" every time project is deployed on TEST environment. Then retrieve current version using command:
```ps
	git describe --tags --abbrev=0
```

This works nice most of the time but if you will create new tag e.g. "v1.44.0.0" and then try to merge origin using *git rebase* you're gonna have a bad time.

Rebase will stash your changes, download origin and apply changes again. This causes git to recreate your commits with new SHA-1 which is ok but tag will still be connected to old SHA-1 and will be disconnected from the branch.




