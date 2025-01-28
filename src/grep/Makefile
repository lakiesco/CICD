CC=gcc
CFLAGS=-Wall -Werror -Wextra -std=c11
SOURCE2=s21_grep.c

EXE2=s21_grep

.PHONY: clean rebuild

all: s21_cat

s21_cat: $(SOURCE2)
	$(CC) $(CFLAGS) $(SOURCE2) -o $(EXE2)

test: s21_cat
	python3 test_grep.py

clean:
	rm -f *.o $(EXE2)

rebuild: clean all
