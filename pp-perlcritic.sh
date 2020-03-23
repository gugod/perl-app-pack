#!/bin/bash

cpm install -g Perl::Critic           \
    Perl::Critic::Bangs               \
    Perl::Critic::Freenode            \
    Perl::Critic::Itch                \
    Perl::Critic::More                \
    Perl::Critic::OTRS                \
    Perl::Critic::Pulp                \
    Perl::Critic::Swift               \
    Perl::Critic::Tics                \
    Perl::Critic::TooMuchCode         \
    Perl::Critic::Moose               \
    Perl::Critic::RENEEB              \
    Perl::Critic::CognitiveComplexity

pp -o perlcritic $(which perlcritic)
