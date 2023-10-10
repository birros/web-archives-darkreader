VERSION ?= develop

ifneq (,$(wildcard ./.arg))
	include .arg
	export
endif

all: build

darkreader:\
	.arg \
	patches/web-archives.patch

	git clone https://github.com/darkreader/darkreader.git
	cd darkreader && \
		git checkout . && \
		git clean -xdf && \
		git checkout main && \
		git pull && \
		git checkout ${DARKREADER_COMMIT} && \
		patch -p1 < ../patches/web-archives.patch

darkreader/build/web-archives/build/darkreader.js:\
	darkreader

	cd darkreader && \
		npm ci && \
		npm run build

	ls darkreader/build/web-archives/build/darkreader.js

build/web-archives-darkreader_${VERSION}.js:\
	darkreader/build/web-archives/build/darkreader.js

	rm -rf build/web-archives-darkreader.js
	mkdir -p build
	cp \
		darkreader/build/web-archives/build/darkreader.js \
		build/web-archives-darkreader_${VERSION}.js

.PHONY: build
build: build/web-archives-darkreader_${VERSION}.js
