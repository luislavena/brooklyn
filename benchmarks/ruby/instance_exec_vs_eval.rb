require "benchmark"

class Foo
  def ping
  end
end

block = Proc.new {
  ping
}

object = Foo.new

TESTS = 100_000
Benchmark.bmbm do |results|
  results.report("noop:") { TESTS.times { } }
  results.report("instance_eval:") { TESTS.times { object.instance_eval(&block) } }
  results.report("instance_exec:") { TESTS.times { object.instance_exec(&block) } }
end
