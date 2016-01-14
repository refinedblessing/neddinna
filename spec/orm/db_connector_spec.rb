require "spec_helper"

RSpec.describe Neddinna::DbConnector do
  let(:db_path) { Neddinna::DbConnector.db_path }

  before :all do
    setup_table
  end

  after :all do
    ENV["RACK_ENV"] = "test"
  end

  describe "#db_path" do
    it "should not be nil" do
      expect(Neddinna::DbConnector.db_path).not_to be nil
    end
  end

  describe "#db_file" do
    it "should return test_db file for test environments" do
      expect(Neddinna::DbConnector.db_file).to eq db_path + "/test.sqlite3"
    end

    it "should return app_db file for non-test environments" do
      ENV["RACK_ENV"] = "production"
      expect(Neddinna::DbConnector.db_file).to eq db_path + "/app.sqlite3"
    end
  end

  describe "#connect" do
    it "should return a DB connection" do
      expect(Neddinna::DbConnector.connect.class).to eq SQLite3::Database
    end
  end

  describe "#connection" do
    it "should return a DB connection" do
      expect(Neddinna::DbConnector.connection.class).to eq SQLite3::Database
    end
  end
end
