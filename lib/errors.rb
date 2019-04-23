# frozen_string_literal: true

module Errors
  class Validator
    def self.validate(db_name, db_table, file, elements)
      raise DbNameError, DbNameError.message unless /[A-Za-z]/.match?(db_name)
      raise DbTableNameError, DbTableNameError.message unless /[A-Za-z]/.match?(db_table)
      raise FileError, FileError.message unless File.file?(file)
      raise ElementsNotAHashError, ElementsNotAHashError.message unless check_hash(elements)
    end

    def self.check_hash(elements)
      elements.size == 4 && elements.all? { |key, value| /[A-Za-z]/.match?(key) && /[A-Za-z]/.match?(value) }
    end
  end

  class DbNameError < StandardError
    def self.message
      'DB name must be string with (A-Z, a-z symbols allowed).'
    end
  end

  class DbTableNameError < StandardError
    def self.message
      'DB table name must be string with (A-Z, a-z symbols allowed).'
    end
  end

  class FileError < StandardError
    def self.message
      'Path for *.xml must be valid filename.'
    end
  end

  class ElementsNotAHashError < StandardError
    def self.message
      'Parameters for parsing must be a hash with string key/values.'
    end
  end
end
