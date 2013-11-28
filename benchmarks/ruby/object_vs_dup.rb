require "benchmark"

class Request
end

class Response
end

class Route
end

class Scope
  attr_reader :response, :request

  def initialize(request, route, data)
    @response = Response.new
    @request  = request

    merge_params(data)
  end

  private

  def merge_params(data)
    # no op
  end
end

class DupScope
  attr_accessor :request, :response, :route

  def initialize
    @response = Response.new
  end

  def dup!(request, route, data)
    dup.tap do |scope|
      scope.request = request
      scope.route   = route

      scope.merge_params(data)
    end
  end

  def merge_params(data)
    # no op
  end
end

request    = Request.new
route      = Route.new
data       = {}
base_scope = DupScope.new

TESTS = 100_000
Benchmark.bmbm do |results|
  results.report("new:") { TESTS.times { Scope.new(request, route, data) } }
  results.report("dup:") { TESTS.times { base_scope.dup!(request, route, data) } }
end
