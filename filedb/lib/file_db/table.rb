module FileDb
  class Table
    def initialize(table_name, table_data, db)
      @table_name = table_name
      @table_data = table_data
      @db = db
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
    
    def insert(row)
      @table_data << row
      @db.persist(@table_name, @table_data)
    end
    
    def delete(params)
      @table_data = @table_data.reject{ |row| row['id'] == params[:where][:id] }
      @db.persist(@table_name, @table_data)
    end
  end
end
