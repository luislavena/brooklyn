module Brooklyn
  class Route
    attr_reader :block, :path

    def initialize(path, &block)
      @block         = block
      @extras        = []
      @path          = path
      @compiled_path = compile
    end

    def match?(other_path)
      return unless @compiled_path =~ other_path

      # return a hash with { :key => value }
      Hash[$~.names.map(&:to_sym).zip($~.captures)]
    end

    private

    def compile
      named_path = @path.gsub(/:\w+/) do |match|
        name = match.gsub(':', '')
        @extras.push name.to_sym

        "(?<#{name}>[^/?#]+)"
      end

      Regexp.new("^#{named_path}$")
    end
  end
end
