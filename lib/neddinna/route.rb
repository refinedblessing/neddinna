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
      klass.new(env).send(method.to_sym)
    end
  end
end
