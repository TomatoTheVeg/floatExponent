CFLAGS= -O0 -g

.PHONY: all
.PHONY: clean 

all: exp

exp: tester.c expo.S
	$(CC) $(CFLAGS) -o $@ $^
clean:
	rm -f exp
 