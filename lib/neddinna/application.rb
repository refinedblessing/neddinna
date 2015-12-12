module Neddinna
  class Application
    def call(*)
      [200, {}, ["Hello Africa"]]
    end
  end
end
