# frozen_string_literal: true

require 'xml'

module Xmlgenerator
  include LibXML

  class Testgenerator
    def generate(number, table_name, node_name, filename)
      document = XML::Document.new
      root = create_node(table_name)
      id = 1
      number.times do
        visit = create_node(node_name)
        add_data(visit, id)
        root << visit
        id += 1
      end
      document.root = root
      document.save(filename)
    end

    private

    def add_namespaces(node, namespaces)
      default = namespaces.delete('default')
      node.namespaces.namespace = XML::Namespace.new(node, nil, default)
      namespaces.each do |prefix, prefix_uri|
        XML::Namespace.new(node, prefix, prefix_uri)
      end
    end

    def add_attributes(node, attributes)
      attributes.each do |name, value|
        XML::Attr.new(node, name, value)
      end
    end

    def create_node(name, value = nil, options = {})
      node = XML::Node.new(name)

      namespaces = options.delete(:namespaces)
      add_namespaces(node, namespaces) if namespaces

      attributes = options.delete(:attributes)
      add_attributes(node, attributes) if attributes
      node << value
    end

    def add_data(node, id)
      end_at = random_time
      node << create_node('id', id)
      node << create_node('start_at', (end_at - rand(3600)).strftime('%F-%H:%M'))
      node << create_node('end_at', end_at.strftime('%F-%H:%M'))
      node << create_node('sum', Random.rand(10_000.0).round(2))
    end

    def random_time
      Time.at(rand * (Time.now - 3600).to_f)
    end
  end
end
