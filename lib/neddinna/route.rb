module Neddinna
  class Route
    attr_accessor :klass_name, :path, :method
    def initialize(route_array)
      @path = route_array.first
      @klass_name = route_array.last[:klass]
      @method = route_array.last[:method]
    end

    def klass
      Module.const_get(klass_name + "Controller")
    end

    def execute(env)
      controller = klass.new(env)
      text = controller.send(method.to_sym)
      if controller.get_response
        status, header, response = controller.get_response.to_a
        [status, header, [response.body].flatten]
      elsif controller.template(method)
        controller.render method
      else
        [200, { "Content-Type" => "text/html" }, [text]]
      end
    end
  end
end
