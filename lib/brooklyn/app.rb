require "rack/builder"
require "rack/request"

require "brooklyn/request_scope"
require "brooklyn/route_set"

module Brooklyn
  class App
    class << self
      %w(DELETE GET HEAD OPTIONS PATCH POST PUT).each do |verb|
        define_method(verb.downcase) { |path, &block|
          route_set.add verb, path, &block
        }
      end

      alias_method :_new, :new
      def new(*args, &block)
        stack.run _new(*args, &block)
        stack
      end

      def helpers(*modules, &block)
        block_given? and
          modules.push Module.new(&block)

        modules.each do |mod|
          request_scope_klass.send(:include, mod)
        end
      end

      def map(path, &block)
        stack.map(path, &block)
      end

      # FIXME: this is not properly inheriting the parent instance
      def request_scope_klass
        super_klass = defined?(super) ? super : RequestScope
        @@request_scope_klass ||= Class.new(super_klass)
      end

      def route_set
        @route_set ||= RouteSet.new
      end

      def stack
        @stack ||= Rack::Builder.new
      end

      def use(middleware, *args, &block)
        stack.use(middleware, *args, &block)
      end
    end

    def call(env)
      # normalize PATH_INFO if missing
      env["PATH_INFO"].empty? and
        env["PATH_INFO"] = "/"

      # construct request & response
      request = Rack::Request.new(env)

      # lookup for route
      route, data = self.class.route_set.find(request.request_method,
                                              request.path_info)

      route or
        return pass

      process_request(request, route, data)
    end

    private

    def pass
      [404, {}, []]
    end

    def process_request(request, route, data)
      scope = self.class.request_scope_klass.new(request, route, data)
      scope.execute
      scope.finish
    end
  end
end
