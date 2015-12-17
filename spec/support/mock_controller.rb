class MockController < Neddinna::BaseController
  def index
    "Mock index #{params['id']}"
  end

  def create
    "Mock create"
  end

  def update
    "Mock update"
  end

  def destroy
    "Mock destroy"
  end
end
