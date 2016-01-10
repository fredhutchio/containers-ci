SRC=src/ci.md
DST=ci.html

all: $(DST)

%.html: src/%.md
	./build.sh src/$*.md $@

continuous:
	while :; do inotifywait -e modify $(SRC); make $(DST); done

.PHONY: continuous all
