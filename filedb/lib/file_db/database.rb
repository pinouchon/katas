require 'json'
require 'pry'
require 'active_support/core_ext/hash/slice'

module FileDb
  class Database
    def initialize(data_file)
      @data_file = data_file
      @data = JSON.parse(File.read(data_file))
    end

    def table_names
      @data.keys
    end

    def table(table_name)
      FileDb::Table.new(table_name, @data[table_name])
    end
  end
end
