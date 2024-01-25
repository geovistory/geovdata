.DEFAULT_GOAL := clean

clean:
	rm -rf ./build
	rm -rf ./dist
	rm -rf ./geovdata.egg-info

upgrade-version-patch:
	python3 setup-prepare.py patch

upgrade-version-minor:
	python3 setup-prepare.py minor

upgrade-version-major:
	python3 setup-prepare.py major

build:
	python3 setup.py sdist bdist_wheel

publish:
	twine upload dist/*

install-local:
	pip install -e .

push:
	version=$(shell cat version.txt)
	git add .
	git commit -m "v$$(cat version.txt)"
	git push origin main

publish-patch: clean upgrade-version-patch build publish push install
publish-minor: clean upgrade-version-minor build publish push install
publish-major: clean upgrade-version-major build publish push install
install: clean build install