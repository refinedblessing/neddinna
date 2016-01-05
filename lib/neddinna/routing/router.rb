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
      get("/#{name}/:id/edit", to: "#{name}#edit")
      post("/#{name}", to: "#{name}#create")
      patch("/#{name}/:id", to: "#{name}#update")
      put("/#{name}/:id", to: "#{name}#update")
      delete("/#{name}/:id", to: "#{name}#destroy")
    end

    def draw(&block)
      instance_eval(&block)
    end

    def self.setup_verbs(*verbs)
      verbs.each do |verb|
        define_method(verb) do |path, options = {}|
          url_parts = path.split("/")
          url_parts.select! { |part| !part.empty? }
          placeholders = []
          regexp_parts = url_parts.map do |part|
            if part[0] == ":"
              placeholders << part[1..-1]
              "([A-Za-z0-9_]+)"
            else
              part
            end
          end
          regexp = regexp_parts.join("/")
          routes[verb] << [Regexp.new("^/#{regexp}$"),
                           parse_to(options[:to]), placeholders]
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
        placeholders = {}
        match = route_array.first.match(path)
        route_array[2].each_with_index do |placeholder, index|
          placeholders[placeholder] = match.captures[index]
        end
        route_array << placeholders
        return Route.new(route_array)
      end
      nil
    end

    private

    def parse_to(to_string)
      klass, method = to_string.split("#")
      { klass: klass.to_camel_case, method: method }
    end
  end
end
