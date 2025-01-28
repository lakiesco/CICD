CC=gcc
CFLAGS=-Wall -Werror -Wextra -std=c11
SOURCE1=s21_cat.c

EXE1=s21_cat

.PHONY: clean rebuild

all: s21_cat

s21_cat: $(SOURCE1)
	$(CC) $(CFLAGS) $(SOURCE1) -o $(EXE1)

test: s21_cat
	python3 taest_cat.py

clean:
	rm -f *.o $(EXE1)

rebuild: clean all
