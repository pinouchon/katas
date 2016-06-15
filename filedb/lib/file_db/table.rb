module FileDb
  class Table
    def initialize(table_name, table_data)
      @table_name = table_name
      @table_data = table_data
    end

    def select(params)
      result = @table_data

      if params[:where]
        params[:where].each do |field, value|
          result = result.select { |row| row[field.to_s] == value }
        end
      end

      if params[:fields]
        result = result.map { |row| row.slice(*params[:fields].map(&:to_s)) }
      end

      result

    end
  end
end
