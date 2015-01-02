# -*- encoding : utf-8 -*-
module ActiveSupport::JSON::Encoding
  class << self
    def escape(string)
      if string.respond_to?(:force_encoding)
        string = string.encode(::Encoding::UTF_8, :undef => :replace).force_encoding(::Encoding::BINARY)
      end
      json = string.gsub(escape_regex) { |s| ESCAPED_CHARS[s] }
      json = %("#{json}")
      json.force_encoding(::Encoding::UTF_8) if json.respond_to?(:force_encoding)
      json
    end
  end
end
