CFLAGS:= -Wall -DDEBUG -Iinclude -Llib -m64
CRITERION:= $(CFLAGS) -lcriterion

LIBS:=$(patsubst src/%.c, lib/%.o, $(wildcard src/*.c))

TESTS:=$(patsubst test/%.c, test/%.o, $(wildcard test/*.c))
DISTS:=$(patsubst test/test_%.o, lib/%.o, $(TESTS))
DODISTS:=$(patsubst test/test_%.o, test/test_%.test,$(TESTS))

.PHONY:mkdir test

all: clean test

clean:
	@rm -fr */*.o
	@rm -fr */*.ts

$(LIBS):lib/%.o: src/%.c
	@gcc -o $@ -c $< $(CFLAGS) 

$(TESTS):test/%.o : test/%.c
	@gcc -o $@ -c $< $(CFLAGS)

$(DODISTS): $(TESTS) $(DISTS)
	@gcc -o $@ $^ $(CRITERION)

test: $(LIBS) $(TESTS) $(DODISTS)
	@test/test_*.test

mkdir:
	@mkdir src lib include test test