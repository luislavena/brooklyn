require "brooklyn/route"

module Brooklyn
  class RouteSet
    def initialize
      @routes = Hash.new { |h, k| h[k] = [] }
    end

    def add(method, path, &block)
      @routes[method].push Route.new(path, &block)
    end

    def find(method, path)
      data  = nil
      route = @routes[method].find { |r| data = r.match?(path) }

      [route, data]
    end
  end
end
