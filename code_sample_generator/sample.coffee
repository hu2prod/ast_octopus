module.exports = ()->
  [
    # """
    #   var x:int
    #   x = 5
    # """    # BUG: fails on multiline inputs in Rust
    "1"
    "1.1"
    # '"1"'  # BUG: can't tokenize '"1"
    "true"
    "!true"
    "-1"
    "~5"
    "2 + 2"
    "2 - 2.2"   # Mismatch due to different float precision in JS vs Rust
    "2.2 * 2"
    "5 / 2"
    "5 / 3"     # Mismatch due to different float precision in JS vs Rust
    "5 % 3"
    "5 ** 2"
    "5.5 ** 2"    # (here and below, wherever float arithmetics occurs)
    "5 ** 2.5"
    "5.5 ** 2.5"
    "true && false"
    "true || false"
    "true ^^ false"
    "5 & 7"
    "5 | 7"
    "5 ^ 7"
    "17 >> 3"
    "17 << 3"
    "17 >>> 3"
    "5 >= 7"
    "5.5 <= 7.7"
    "true == true"
    "false != false"
    "5.5 > 7.7"
    "5 < 7"
  ]
