require "erb"
require "tilt"
module Neddinna
  class BaseController
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def klass
      self.class.to_s.gsub(/Controller$/, "").to_snake_case
    end

    def template(view)
      return false unless File.exist?("app/views/#{klass}/#{view}.html.erb")
      Tilt::ERBTemplate.new("app/views/#{klass}/#{view}.html.erb")
    end

    def render(view, locals = {}, obj = nil)
      instance_variables.each do |name|
        locals[name[1..-1]] = instance_variable_get(name)
      end
      response(template(view).render(obj, locals))
    end

    def response(body, status = 200, headers = {})
      raise DoubleRenderError if @response
      text = [body].flatten
      @response = Rack::Response.new(text, status, headers)
    end

    def get_response
      @response
    end

    def params
      request.params
    end
  end
end
