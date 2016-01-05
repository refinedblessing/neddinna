require "spec_helper"

describe Neddinna do
  it "has a version number" do
    expect(Neddinna::VERSION).not_to be nil
  end

  it "adds the to_snake_case method to string class" do
    expect("Ned::App".to_snake_case).
      to eql "ned/app"
  end

  it "adds the to_snake_case method to string class" do
    expect("MyTaskApp".to_snake_case).
      to eql "my_task_app"
  end

  it "adds the to_camel_case method to string class" do
    expect("app_controller".to_camel_case).
      to eql "AppController"
  end
end
