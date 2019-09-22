class Code
  class Object < Hash
    def method_missing(method, *arguments, &block)
      fetch_missing(method)
    end

    def fetch_missing(name)
      convert_missing(fetch(name.to_s) { fetch(name.to_symbol) } )
    end

    private

    def convert_missing(value)
      if value.is_a?(Array)
        value.map { |v| convert(v) }
      elsif value.is_a?(Hash)
        Code::Object[value]
      else
        value
      end
    end
  end
end
