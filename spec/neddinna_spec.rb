require "spec_helper"

describe Neddinna do
  it "has a version number" do
    expect(Neddinna::VERSION).not_to be nil
  end

  it "includes the to_snake_case method to string class" do
    expect("Ned::App".to_snake_case).
      to eql "ned/app"
  end

  # it "includes the to_snake_case method to string class" do
  #   expect("MyApp".to_snake_case).
  #     to eql "myapp"
  # end

  it "includes the to_camel_case method to string class" do
    expect("app_controller".to_camel_case).
      to eql "AppController"
  end
end
