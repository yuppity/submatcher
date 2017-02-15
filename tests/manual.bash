#!/usr/bin/env bash

source "$(dirname $0)"/setup.bash

mkdir -p test_dir/{original,processed}
for testfile in "${test_files[@]}"; do
  touch test_dir/{original,processed}/"${testfile}"
done


