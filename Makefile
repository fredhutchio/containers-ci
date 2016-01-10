SRC=src/ci.md
DST=index.html

all: $(DST)

index.html: src/ci.md
	./build.sh src/ci.md $@

continuous:
	while :; do inotifywait -e modify $(SRC); make $(DST); done

.PHONY: continuous all
