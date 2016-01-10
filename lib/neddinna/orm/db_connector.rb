require "sqlite3"
module Neddinna
  class DbConnector
    class << self
      def connect
        db_dir = "#{APP_PATH}/db/app.sqlite3"
        Dir.mkdir("#{APP_PATH}/db") unless File.exist?(db_dir)
        @db_conn ||= SQLite3::Database.new db_dir
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
