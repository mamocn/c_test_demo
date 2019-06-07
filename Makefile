CFLAGS:= -Wall -DDEBUG -Iinclude -Llib -m64
CRITERION:= $(CFLAGS) -lcriterion

LIBS:=$(patsubst src/%.c, tmp/lib/%.o, $(wildcard src/*.c))
TESTS:=$(patsubst test/%.c, tmp/lib/%.o, $(wildcard test/*.c))

DISTS:=$(patsubst tmp/lib/test_%.o, tmp/lib/%.o, $(TESTS))
BINS:=$(patsubst tmp/lib/test_%.o, tmp/bin/test_%.test,$(TESTS))

.PHONY:mkdir test

all: clean test 

clean:
	@rm -fr tmp/lib/* tmp/bin/*

$(LIBS):tmp/lib/%.o: src/%.c
	@gcc -o $@ -c $< $(CFLAGS) 

$(TESTS):tmp/lib/%.o : test/%.c
	@gcc -o $@ -c $< $(CFLAGS)

$(BINS): $(TESTS) $(DISTS)
	@gcc -o $@ $^ $(CRITERION)

test: $(LIBS) $(TESTS) $(BINS)
	@tmp/bin/test_*.test

mkdir:
	@mkdir -p include src test tmp/lib tmp/bin

