#!/usr/bin/env bash

source "$(dirname $0)"/setup.bash

failtest() {
  echo "FAILED"
  exit 1
}

passtest() {
  echo "PASSED"
  exit 0
}

declare -a results
results=( ${TDIR}/* )

[[ ${#expected_files[@]} -ne ${#results[@]} ]] && failtest
for result in "${results[@]}"; do
  for expected in "${expected_files[@]}"; do
    [[ "${result}" == "${TDIR}/${expected}" ]] && continue 2
  done
  failtest
done
passtest
