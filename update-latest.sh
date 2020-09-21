#!/bin/bash

echo "cp -R ./source/includes/ ./source/v2/includes && cp ./source/index.html.md ./source/v2" > ./.git/hooks/pre-commit
chmod +x ./.git/hooks/pre-commit
