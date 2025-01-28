#include "s21_cat.h"

int main(int argc, char **argv) {
  char flags[7] = "\0";
  int flags_end_index = 0;
  int index = 0;

    parse_flags(argc, argv, flags, &flags_end_index);

  if (flags_end_index == argc - 1 || argc == 1) {
    print_file("-", flags, &index);
  } else {
    for (int i = flags_end_index + 1; i < argc; i++) {
      if (strcmp(argv[i], "--") == 0)
        continue;

      print_file(argv[i], flags, &index);
    }
  }

  return 0;
}

void parse_flags(int argc, char **argv, char *flags, int *index) {
  const struct option long_flags[] = {{"number-nonblank", 0, NULL, 'b'},
                                      {"number", 0, NULL, 'n'},
                                      {"squeeze-blank", 0, NULL, 's'},
                                      {NULL, 0, NULL, 0}};

  int current_flag;
  while ((current_flag =
              getopt_long(argc, argv, "bevEnstT", long_flags, NULL)) != -1) {
    switch (current_flag) {
    case 'b':
      append_flag(flags, 'b');
      break;
    case 'e':
      append_flag(flags, 'E');
      append_flag(flags, 'v');
      break;
    case 'v':
      append_flag(flags, 'v');
      break;
    case 'E':
      append_flag(flags, 'E');
      break;
    case 'n':
      append_flag(flags, 'n');
      break;
    case 's':
      append_flag(flags, 's');
      break;
    case 't':
      append_flag(flags, 'T');
      append_flag(flags, 'v');
      break;
    case 'T':
      append_flag(flags, 'T');
      break;
    default:
      exit(EXIT_FAILURE);
    }
    *index = optind - 1;
  }
}

void append_flag(char *flags, char flag) {
  if (strchr(flags, flag) == NULL) {
    char temp[2] = {flag, '\0'};
    strcat(flags, temp);
  }
}

void print_file(char *name, char *flags, int *index) {
  FILE *file;

  if (strcmp(name, "-") == 0) {
    file = stdin;
  } else {
    file = fopen(name, "r");
  }

  if (file != NULL) {
    bool eline_printed = 0;
    int c = fgetc(file), prev = '\n';

    while (c != EOF) {
      print_symb(c, &prev, flags, index, &eline_printed);
      c = fgetc(file);
    }
    if (file != stdin)
      fclose(file);
  } else {
    fprintf(stderr, "cat: %s: No such file or directory\n", name);
    exit(EXIT_FAILURE);
  }
}

void print_symb(int c, int *prev, char *flags, int *index,
                bool *eline_printed) {
  if (!(strchr(flags, 's') != NULL && *prev == '\n' && c == '\n' &&
        *eline_printed)) {
    if (*prev == '\n' && c == '\n') {
      *eline_printed = 1;
    } else {
      *eline_printed = 0;
    }

    if (((strchr(flags, 'n') != NULL && strchr(flags, 'b') == NULL) ||
         (strchr(flags, 'b') != NULL && c != '\n')) &&
        *prev == '\n') {
      (*index)++;
      printf("%6d\t", *index);
    }

    if (strchr(flags, 'E') != NULL && c == '\n') {
      putchar('$');
    }

    if (strchr(flags, 'T') != NULL && c == '\t') {
      putchar('^');
      c = 'I';
    }

    if (strchr(flags, 'v') != NULL) {
      if (c >= 128) {
        c -= 128;

        printf("M-");
      }
      if ((c < 32 && c != '\n' && c != '\t') || c == 127) {
        c ^= 64;

        printf("^");
      }
    }

    fputc(c, stdout);
  }

  *prev = c;
}
