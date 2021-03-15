#!/bin/bash

cpm install Task::PerlCriticAllPolicies

pp -M Perl::Critic:: -o build/bin/perlcritic local/bin/perlcritic
