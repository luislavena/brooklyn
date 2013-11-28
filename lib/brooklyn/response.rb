module Brooklyn
  class Response
    attr_accessor :status

    attr :headers

    def initialize(status = 200,
                   headers = { "Content-Type" => "text/html; charset=utf-8" })

      @status  = status
      @headers = headers
      @body    = []
      @length  = 0
    end

    def [](key)
      @headers[key]
    end

    def []=(key, value)
      @headers[key] = value
    end

    def finish
      [@status, @headers, @body]
    end

    def write(str)
      s = str.to_s

      @length += s.bytesize
      @headers["Content-Length"] = @length.to_s
      @body << s
    end
  end
end
