module Neddinna
  class Route
    attr_accessor :klass_name, :path, :method, :params
    def initialize(route_array)
      @path = route_array[0]
      @params = route_array.last
      @klass_name = route_array[1][:klass]
      @method = route_array[1][:method]
    end

    def klass
      Module.const_get(klass_name + "Controller")
    end

    def execute(env)
      controller = klass.new(env)
      text = controller.send(method.to_sym)
      controller.add_params(params) if params
      if controller.get_response
        controller.get_response.to_a
      elsif controller.template(method)
        controller.render method
      else
        [200, { "Content-Type" => "text/html" }, [text]]
      end
    end
  end
end
