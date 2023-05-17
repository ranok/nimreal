# Target-agnostic regular expression library
# Author: Jacob Torrey <jacob@thinkst.com>

when defined(c):
  import std/re
when defined(js):
  import std/jsre

type
  RE* = object
    pattern*, flags* : string
    when defined(c):
      regex : Regex
    when defined(js):
      regex : RegExp
  RERef * = ref RE

proc newRE*(pattern : string, flags : string = "i") : RERef =
  when defined(c):
    let r = re(pattern)
  when defined(js):
    let r = newRegExp(pattern, flags)
  return RERef(pattern: pattern, flags: flags, regex: r)

proc toCstring*(re : RERef) : cstring =
  return ("/" & re.pattern & "/" & re.flags).cstring

proc contains*(s : string, re : RERef, start : int = 0) : bool =
  when defined(c):
    return s.contains(re.regex, start)
  when defined(js):
    return s.cstring.contains(re.regex)