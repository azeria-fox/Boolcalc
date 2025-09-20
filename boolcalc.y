%{
    // Includes (libraries)
    #include <stdio.h>
    #include <stdbool.h>
    #include <string.h>

    // Yacc/bison
    int yylex (void);
    extern int yyparse();
    void yyerror (char const *);
    extern FILE *yyin;

    // Function forward declarations
    void display_boolean(bool result);
    void display_help_message();
%}

%define api.value.type {bool}

%token BOOLEAN
%token AND
%token OR
%token NOT
%token XOR
%token NL
%start INPUT

%%
// Input
INPUT:
    %empty
    | INPUT LINE
    ;

// Line definition
LINE:
    NL
    | EXPRESSION NL { display_boolean($1); }
    ;

// Expressions
EXPRESSION:
    BOOLEAN
    | EXPRESSION EXPRESSION AND { $$ = $1 && $2; }
    | EXPRESSION EXPRESSION OR { $$ = $1 || $2; }
    | EXPRESSION EXPRESSION XOR { $$ = $1 ^ $2; }
    | EXPRESSION NOT { $$ = !$1; }
    ;

%%

// Entry point
int main(int argc, char *argv[]) {
    // Welcome message
    puts("Basic Boolean Calculator");

    // Check if help flag was provided
    if (argc > 1 && strcmp(argv[1], "help") == 0) {
        display_help_message();
        return 0;
    }

    // Parse continuously
    yyin = stdin;
    do { yyparse(); } while (!feof(yyin));

    return 0;
}

// Display help message
inline void display_help_message() {
    puts("Help page:");
    puts("The boolean calculator uses postfix notation.");
    puts("E.g. TRUE FALSE &");
    puts("Operands:");
    puts("\t1/true or t (case insensitive) - TRUE");
    puts("\t0/false or f (case insensitive) - FALSE");
    puts("Operators:");
    puts("\t| or OR (case insensitive) - OR operator");
    puts("\t& or AND (case insensitive)  - AND operator");
    puts("\t' or ’ or NOT (case insensitive)  - NOT operator");
    puts("\t^ or XOR (case insensitive)  - XOR operator");
    puts("Hit enter to evaluate the provided expression.");
}

// Illegal character/expression
void yyerror (char const *s) {
    fprintf(stderr, "%s\n",s);

    // Skip the rest of the line
    int token;
    while ((token = yylex()) != NL && token != 0) { /* Skip */ } 
}

// Display results of binary operation to the console
inline void display_boolean(bool result) {
    if (result) puts("TRUE"); else puts("FALSE");
}
