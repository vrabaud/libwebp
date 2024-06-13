#!/bin/sh
# Fixes for https://github.com/google/fuzztest/issues/1124
sed -i -e "s/-fsanitize=address//g" -e "s/-DADDRESS_SANITIZER//g" \
  ./cmake/FuzzTestFlagSetup.cmake
# Fixes for https://github.com/google/fuzztest/issues/1125
before="if (IsEnginePlaceholderInput(data)) return;"
after="if (data.size() == 0) return;"
sed -i "s/${before}/${after}/" ./fuzztest/internal/compatibility_mode.cc
sed -i "s/set(GTEST_HAS_ABSL ON)/set(GTEST_HAS_ABSL OFF)/" \
  ./cmake/BuildDependencies.cmake
# Fixes https://github.com/google/fuzztest/issues/1192
git revert --no-commit ed6f817771702bf7823b73498d0e1914475f2313
