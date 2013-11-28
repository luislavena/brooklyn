require "benchmark"

MODULES = []

puts "100.times modules"
puts Benchmark.measure {
  MODULES.concat 100.times.collect { Module.new }
}

class Empty
end

puts "Full.include modules"
puts Benchmark.measure {
  class Full < Empty
    MODULES.each do |m|
      include m
    end
  end
}

puts "Anonymous include"
puts Benchmark.measure {
  klass = Class.new(Empty)
  MODULES.each do |m|
    klass.include(m)
  end
}

puts "instance extend"
puts Benchmark.measure {
  instance = Empty.new
  MODULES.each do |m|
    instance.extend(m)
  end
}
