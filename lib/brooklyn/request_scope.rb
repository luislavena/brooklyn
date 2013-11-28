require "brooklyn/response"

module Brooklyn
  class RequestScope
    attr_reader :response, :request

    def initialize(request, route, data)
      @request  = request
      @response = Response.new
      @route    = route

      merge_params(data)
    end

    def params
      @request.params
    end

    def execute
      @response.write instance_eval(&@route.block)
    end

    def finish
      @response.finish
    end

    private

    def merge_params(data)
      @request.params.merge!(data)
      @request.params.default_proc = proc { |h, k| h[k.to_s] || h[k.to_sym] }
    end
  end
end
