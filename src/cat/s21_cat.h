#ifndef S21_CAT_H
#define S21_CAT_H

#include <getopt.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void parse_flags(int argc, char **argv, char *flags, int *index);
void append_flag(char *flags, char flag);
void print_file(char *name, char *flags, int *index);
void print_symb(int c, int *prev, char *flags, int *index, bool *eline_printed);

#endif