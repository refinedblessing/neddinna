module Neddinna
  class BaseController
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def params
      request.params
    end
  end
end
