%include {
#include <assert.h>
#include <stdbool.h>
#include "context.h"
#include "parser.h"
}

%left ADD SUB.
%left MUL DIV.
%token_type { double }
%extra_argument { struct Context * context }

formula ::= expr(A).
    { context->result = A; }

expr(A) ::= expr(B) ADD expr(C).
    { A = B + C; }

expr(A) ::= expr(B) SUB expr(C).
    { A = B - C; }

expr(A) ::= expr(B) MUL expr(C).
    { A = B * C; }

expr(A) ::= expr(B) DIV expr(C).
    { A = B / C; }

expr(A) ::= LPAREN expr(B) RPAREN.
    { A = B; }

expr(A) ::= LITERAL(B).
    { A = B; }

%parse_failure
    { context->error = true; }
