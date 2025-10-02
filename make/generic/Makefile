.PHONY: clean push
clean:
	- rm -rf HostlistsRegistry
	- rm -rf meta-rules-dat
	- rm -rf anti-AD

push:
	- git add --all
	- git commit -m "update $(shell date +'%Y%m%d%H%M%S')"
	- git push