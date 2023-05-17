# To run these tests, simply execute `nimble test`.

import unittest

import nimreal

test "test contains()":
  let r = newRE(r"^[0-9]+$", "i")
  check "34523425430".contains(r) == true
  check "asbdsdfser".contains(r) == false
