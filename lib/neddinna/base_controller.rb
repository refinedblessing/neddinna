require "erb"
require "tilt"
require_relative "orm/base_model"
module Neddinna
  class BaseController
    attr_reader :request
    attr_accessor :params

    def initialize(request)
      @request = request
      @params = {}
      @params.merge!(request.params) if request.params
    end

    def klass_folder_name
      self.class.to_s.gsub(/Controller$/, "").to_snake_case
    end

    def template(view)
      file = "#{APP_PATH}/app/views/#{klass_folder_name}/#{view}.html.erb"
      return false unless File.exist?(file)
      Tilt::ERBTemplate.new(file)
    end

    def render(view, obj = nil, locals = {})
      variables = instance_variables
      variables.each do |name|
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

    def add_params(hash)
      @params.merge!(hash)
    end
  end
end
