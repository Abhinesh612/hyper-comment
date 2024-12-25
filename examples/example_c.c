// FIXME: fixme arch linux
// Bug: Are you a bug?
// TODO: Don't forget to do it
// WARNING: I'm here
// Deprecated: Who are you?
// review: hmmm
// hack: Mr. Robot?
// note: I was never here
// PREF: sudo rm -f / 
#include <stdio.h>
/**
 * Prints the given message to the standard output.
 * 
 * @param message A pointer to a null-terminated string containing the message to be printed.
 *                This string will be printed followed by a newline character.
 */
void print_msg(const char *message) {
    printf("%s\n", message); 
}

/**
 * The entry point of the program.
 * 
 * @param argc The argument count, which indicates how many arguments are passed to the program.
 * @param argv An array of strings representing the command-line arguments. 
 *             The first argument (argv[0]) is the program's name.
 * 
 * @return Returns 0 to indicate successful execution.
 */
int main(int argc, char *argv[]) {
    (void) argc;
    (void) argv;
    print_msg("Hello, World\n");
    return 0;
}
