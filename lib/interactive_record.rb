require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
    def self.inherited(child_class)
        child_class.column_names.each do |column_name|
            attr_accessor column_name.to_sym
        end
    end

    def self.table_name
        "#{self.to_s.downcase.pluralize}"
    end

    def self.column_namesDB[:conn].results_as_hash = true

        sql = "PRAGMA table_info('#{table_name}')"
        table_info = DB[:conn].execute(sql)

        column_name = []
        table_info.each do |column|
            column_names << column["name"]
        end
        column_names.compact
    end
end