# frozen_string_literal: true

require 'bundler/setup'
require 'errors'
require 'libxml'
require 'upsert'
require 'pg'

Bundler.require

module Xmlparser
  include LibXML

  class Parser
    def parse_file(db_name, db_table, file, elements)
      Errors::Validator.validate(db_name, db_table, file, elements)
      document = Xmlparser::XML::Parser.file(file).parse
      data = find_elements(db_table, document, elements)
      to_db(db_name, db_table, data, elements)
    end

    private

    def to_db(db_name, db_table, data, elements)
      create_db(db_name, db_table, elements)
      connection = PG.connect(dbname: db_name)
      Upsert.batch(connection, db_table) do |upsert|
        data.each do |item|
          selector = { 'id' => item['id'] }
          item.delete('id')
          upsert.row(selector, item)
        end
      end
    end

    def find_elements(db_table, document, elements)
      data = []
      document.find('//' + db_table).each do |val|
        record = {}
        elements.keys.each do |e|
          item = val.find('.//' + e).first.content
          item = DateTime.strptime(item, '%F-%H:%M').to_s if elements[e] == 'timestamp'
          record[e] = item
        end
        data << record
      end
      data
    end

    def create_db(db_name, db_table, elements)
      columns = elements.map { |k, v| "#{k} #{v}" }.join(",\n") + ','
      connection = PG.connect(dbname: 'template1')
      connection.exec("DROP DATABASE IF EXISTS #{db_name}")
      connection.exec("CREATE DATABASE #{db_name}")
      connection = PG.connect(dbname: db_name)
      connection.exec("CREATE TABLE #{db_table}(
                       #{columns}
                       PRIMARY KEY (id)
                      );")
    end
  end
end
