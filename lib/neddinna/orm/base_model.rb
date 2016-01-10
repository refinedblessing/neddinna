require_relative "db_connector"
require_relative "queries"
module Neddinna
  class BaseModel < Queries
    @@query_string = []

    def initialize(field_hash = {})
      field_hash.each_pair { |col, val| send("#{col}=", val) }
      self
    end

    class << self
      def to_table(name)
        @@table_name = name
      end

      def property(col_name, desc = {})
        increment = "PRIMARY KEY AUTOINCREMENT"
        desc[:type] = desc[:type].to_s.upcase!
        desc[:nullable] = desc[:nullable] ? "NULL" : "NOT NULL"
        desc[:primary_key] = desc[:primary_key] ? "#{increment}" : ""
        @@query_string << col_name.to_s + " " + desc.values.join(" ")
      end

      def create_table
        q_string = @@query_string.join(", ")
        query =
          "CREATE TABLE IF NOT EXISTS #{@@table_name}(#{q_string})"
        DbConnector.execute(query)
        get_and_set_model_attributes
      end

      def create(field_hash)
        cols = field_hash.keys.join(", ")
        holders = Array.new(field_hash.count, "?").join(", ")
        query = "INSERT INTO #{@@table_name}(#{cols}) VALUES (#{holders})"
        values = field_hash.values
        DbConnector.execute(query, values)
        last
      end

      def get_and_set_model_attributes
        columns = []
        DbConnector.retrieve_columns(@@table_name).each do |column|
          columns << column
          define_method("#{column}=") do |val|
            instance_var = "@#{column}"
            instance_variable_set(instance_var, val)
          end

          define_method(column) do
            instance_var = "@#{column}"
            instance_variable_get(instance_var)
          end
        end

        define_method("model_columns") do
          columns
        end
      end
    end
    Dir[File.join(APP_PATH, "app", "models", "*.rb")].
      each { |file| require file }
    def save
      field_hash = {}
      model_columns.each { |col| field_hash[col] = send(col) }
      attributes = field_hash.keys.join(", ")
      placeholders = Array.new(field_hash.count, "?").join(", ")
      DbConnector.execute("REPLACE INTO #{@@table_name} (#{attributes})\
       VALUES (#{placeholders})", field_hash.values)
      self
    end

    def update(options = {})
      options.each { |col, val| send("#{col}=", val) }
      save
    end
  end
end
