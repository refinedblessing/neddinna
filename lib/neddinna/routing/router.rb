require_relative "route"
module Neddinna
  class Router
    attr_accessor :routes
    def initialize
      @routes = Hash.new { |hash, key| hash[key] = [] }
    end

    def resources(name)
      name = name.to_s
      get("/#{name}", to: "#{name}#index")
      get("/#{name}/new", to: "#{name}#new")
      get("/#{name}/:id", to: "#{name}#show")
      get("/#{name}/edit/:id", to: "#{name}#edit")
      get("/#{name}/delete/:id", to: "#{name}#destroy")
      post("/#{name}", to: "#{name}#create")
      patch("/#{name}/:id", to: "#{name}#update")
      put("/#{name}/:id", to: "#{name}#update")
      post("/#{name}/:id", to: "#{name}#update")
    end

    def draw(&block)
      instance_eval(&block)
    end

    def self.setup_verbs(*verbs)
      verbs.each do |verb|
        define_method(verb) do |path, options = {}|
          url_parts = path.split("/")
          url_parts.select! { |part| !part.empty? }
          placeholder_strings = []
          regexp_parts = url_parts.map do |part|
            if part[0] == ":"
              placeholder_strings << part[1..-1]
              "([A-Za-z0-9_]+)"
            else
              part
            end
          end
          regexp = regexp_parts.join("/")
          routes[verb] << [Regexp.new("^/#{regexp}$"),
                           parse_to(options[:to]), placeholder_strings]
        end
      end
    end

    setup_verbs :get, :post, :patch, :put, :delete

    def route_for(request)
      path = request.path_info
      method = request.request_method.downcase.to_sym
      route_array = routes[method].detect do |route|
        (route.first).match(path)
      end
      if route_array
        placeholder_value = {}
        match = route_array.first.match(path)
        placeholder_strings = route_array[2]
        placeholder_strings.each_with_index do |placeholder, value|
          placeholder_value[placeholder] = match.captures[value]
        end
        route_array << placeholder_value
        return Route.new(route_array)
      end
      nil
    end

    private

    def parse_to(to_option)
      klass, method = to_option.split("#")
      { klass: klass.to_camel_case, method: method }
    end
  end
end
