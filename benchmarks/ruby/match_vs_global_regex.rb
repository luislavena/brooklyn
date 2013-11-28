require "benchmark"

re       = /^\/foo\/([^\/?#]+)$/
named_re = /^\/foo\/(?<id>[^\/?#]+)$/
path     = "/foo/100"

def global_captures(regex, string)
  regex =~ string
  $~.captures.first
end

def global_named(regex, string)
  regex =~ string
  $~.captures.first
end

def match_captures(regex, string)
  m = string.match(regex)
  m.captures.first
end

def named_matches(regex, string)
  m = string.match(regex)
  m.captures.first
end

def scan_captures(regex, string)
  m = string.scan(regex).first
  m.first
end

GC.disable

TESTS = 100_000
Benchmark.bmbm do |results|
  results.report("noop:")                 { TESTS.times { } }
  results.report("$~.captures:")          { TESTS.times { global_captures(re, path) } }
  results.report("named $~.captures:")    { TESTS.times { global_named(named_re, path) } }
  results.report("match.captures:")       { TESTS.times { match_captures(re, path) } }
  results.report("named match.captures:") { TESTS.times { named_matches(named_re, path) } }
  results.report("scan captures:")        { TESTS.times { scan_captures(re, path) } }
  results.report("scan named captures:")  { TESTS.times { scan_captures(named_re, path) } }
end
