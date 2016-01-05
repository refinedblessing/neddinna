require "erb"
require "tilt"
module Neddinna
  class BaseController
    attr_reader :request
    attr_accessor :params

    def initialize(request)
      @request = request
      @params = {}
      @params.merge!(request.params) if request.params
    end

    def klass
      self.class.to_s.gsub(/Controller$/, "").to_snake_case
    end

    def template(view)
      file = "app/views/#{klass}/#{view}.html.erb"
      file.insert(0, "../sample_app/") if ENV["RACK_ENV"] == "test"
      return false unless File.exist?(file)
      Tilt::ERBTemplate.new(file)
    end

    def render(view, locals = {}, obj = nil)
      variables = instance_variables - protected_instance_variables
      variables.each do |name|
        locals[name[1..-1]] = instance_variable_get(name)
      end
      response(template(view).render(obj, locals))
    end

    def protected_instance_variables
      [@request]
    end

    def response(body, status = 200, headers = {})
      raise DoubleRenderError if @response
      text = [body].flatten
      @response = Rack::Response.new(text, status, headers)
    end

    def get_response
      @response
    end

    def add_params(hash)
      @params.merge!(hash)
    end
  end
end
