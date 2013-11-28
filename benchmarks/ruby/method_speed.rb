require "benchmark"

class Foo
  def ping
  end
end

block = Proc.new {
  ping
}

Foo.send(:define_method, "pong", &block)

object = Foo.new

method = object.method("pong")

TESTS = 100_000
Benchmark.bmbm do |results|
  results.report("noop:") { TESTS.times { } }
  results.report("method:") { TESTS.times { object.ping } }
  results.report("instance_eval:") { TESTS.times { object.instance_eval &block } }
  results.report("define_method:") { TESTS.times { object.pong } }
  results.report("method.call:") { TESTS.times { method.call } }
  results.report("send:") { TESTS.times { object.send("pong") } }
end
