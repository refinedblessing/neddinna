module Neddinna
  class Queries
    class << self
      def table_name
        @name ||= to_s.downcase + "s"
      end

      def first(num = 1)
        query = "SELECT * FROM #{table_name}\
          ORDER BY #{table_name}.id ASC LIMIT #{num}"
        give_result(executor(query))
      end

      def last(num = 1)
        query = "SELECT * FROM #{table_name} ORDER BY #{table_name}.id DESC\
         LIMIT #{num}"
        give_result(executor(query))
      end

      def take(num = 1)
        give_result(executor "SELECT * FROM #{table_name} LIMIT #{num}")
      end

      def all
        query = "SELECT * FROM #{table_name}"
        executor(query)
      end

      def find(*id)
        values = [id].flatten
        query = "SELECT * FROM #{table_name} WHERE\
         (#{table_name}.id IN (#{values.join(', ')}))"
        report = executor(query)
        return report.first if values.count == 1 && !report.empty?
        report
      end

      def find_by(col, val)
        query = "SELECT * FROM #{table_name} WHERE\
         (#{col} = '#{val}') LIMIT 1"
        give_result(executor(query))
      end

      def where(field_hash)
        clause =
          field_hash.map { |col, val| "#{col} = '#{val}'" }.join(" AND ")
        executor("SELECT * FROM #{table_name} WHERE (#{clause})")
      end

      def destroy(id)
        query = "DELETE FROM #{table_name} WHERE id = #{id}"
        executor(query)
      end

      def destroy_all
        executor("DELETE FROM #{table_name}")
      end

      def executor(query)
        result = []
        rows = DbConnector.execute(query)
        if rows
          rows.each { |row| result << new(row.reject! { |k| !k.is_a? String }) }
        end
        result
      end

      def give_result(report)
        return report.first if report.count == 1
        report
      end
    end

    def destroy
      self.class.destroy(id)
    end
  end
end
