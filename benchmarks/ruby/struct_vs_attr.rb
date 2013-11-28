require "benchmark"

class Foo < Struct.new(:one, :two)
  def self.build(one)
    new.tap { |r|
      r.one = one
      r.two = 100
    }
  end
end

class Bar
  attr_accessor :one, :two

  def self.build(one)
    new.tap { |r|
      r.one = one
      r.two = 100
    }
  end
end

TESTS = 100_000
Benchmark.bmbm do |results|
  results.report("Struct.build:") { TESTS.times { Foo.build(100) } }
  results.report("Class.build:")  { TESTS.times { Bar.build(100) } }
end
