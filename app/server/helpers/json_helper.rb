module Translations
  module JsonHelper
    def json_data
      @json_data ||= JSON.parse(request.body.read)
    end
  end
end
