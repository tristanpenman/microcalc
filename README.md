# Microcalc

## Overview

This repo contains material prepared for a talk delivered in April 2019 at the Melbourne C++ Meetup.

Faced with the problem of implementing a parser for arithmetic expressions, many C++ programmers would start with Flex and Bison. However, in this repo, we see how two alternatives, Ragel and Lemon, can be used to build a parser for simple arithmetic expressions.

## Tokeniser

In the first part of my talk I show how we can generate a tokeniser using Ragel. This program simply generates a series of tokens for a hard-coded input string.

For reference, the hard-coded string is:

    (1.2 + 1) * 2.5

Assuming that `ragel` has been installed, the tokeniser can be built using `make`:

    make tokeniser

Running the tokeniser (`./tokeniser`) should produce the following output:

    LPARENS
    LITERAL(1.2)
    ADD
    LITERAL(1)
    RPARENS
    MUL
    LITERAL(2.5)

The tokeniser is entirely defined within 'tokeniser.rl'.

## Calculator

The calculator involves two parts:

 * calculator.rl
 * parser.y

 While 'parser.y' is responsible for parsing a sequence of tokens that represent an arithmetic expression, 'calculator.rl' is responsible for generating those tokens, and presenting the final result.

 Assuming that 'lemon' has been installed, the calculator can be built using `make`:

    make calculator

## Usage

The calculator provides a very simple [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) for evaluating arithmetic expressions.


When you run `./calculator`, you will see the prompt:

    >

At this prompt, you can enter various expressions, which the calculator will evaluate, before printing the result:

    > (1.2 + 1) * 2.5
    5.5

Invalid input should be identified appropriately, whether it be lexically invalid or syntactically invalid:

    > Boo!
    Error: Invalid input.
    > ((1 + 1)
    Error: Invalid input.

## License

Microcalc is licensed under the Simplified BSD License. See the LICENSE file for more information.
