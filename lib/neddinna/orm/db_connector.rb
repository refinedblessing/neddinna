require "sqlite3"
module Neddinna
  class DbConnector
    class << self
      def db_path
        "#{APP_PATH}/db"
      end

      def db_file
        if ENV["RACK_ENV"] == "test"
          "#{db_path}/test.sqlite3"
        else
          "#{db_path}/app.sqlite3"
        end
      end

      def connect
        Dir.mkdir(db_path) unless File.exist?(db_path)
        @db_conn ||= SQLite3::Database.new db_file
        @db_conn.results_as_hash = true
        connection
      end

      def connection
        @db_conn ||= connect
      end

      def retrieve_columns(table_name)
        column_names = []
        connection.execute("PRAGMA table_info(#{table_name});").
          each { |arr| column_names << arr[1] }
        column_names
      end

      def execute(query, values = nil)
        connection.execute(query, values)
      rescue SQLite3::Exception => exp
        puts exp
      end
    end
  end
end
