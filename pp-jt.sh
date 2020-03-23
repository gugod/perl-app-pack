#!/bin/bash

cpm install -g App::jt Text::CSV_PP Regexp::Common Data::Record

pp -M Text::CSV_PP -M Regexp::Common -M Data::Record -M MooX::Options -M MooX::Options::Role -M MooX::Locale::Passthrough -o jt $(which jt)
