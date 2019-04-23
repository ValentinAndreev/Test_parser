# frozen_string_literal: true

require 'spec_helper'
require 'xmlparser'

RSpec.describe Xmlparser::Parser do
  it 'raise error with no arguments' do
    expect { described_class.new.parse_file }.to raise_error(ArgumentError)
  end

  it 'raise error with wrong db name' do
    expect do
      described_class.new.parse_file('', 'visit', 'sample.xml',
                                     'id' => 'integer', 'start_at' => 'timestamp',
                                     'end_at' => 'timestamp', 'sum' => 'double precision')
    end    .to raise_error(Errors::DbNameError)
  end

  it 'raise error with wrong db table name' do
    expect do
      described_class.new.parse_file('sample', '', 'sample.xml',
                                     'id' => 'integer', 'start_at' => 'timestamp',
                                     'end_at' => 'timestamp', 'sum' => 'double precision')
    end    .to raise_error(Errors::DbTableNameError)
  end

  it 'raise error with wrong file for parsing' do
    expect do
      described_class.new.parse_file('sample', 'visit', '',
                                     'id' => 'integer', 'start_at' => 'timestamp',
                                     'end_at' => 'timestamp', 'sum' => 'double precision')
    end    .to raise_error(Errors::FileError)
  end

  it 'raise error with wrong hash parameters for parsing' do
    expect do
      described_class.new.parse_file('sample', 'visit', 'sample.xml',
                                     'id' => '', 'start_at' => 'timestamp',
                                     'end_at' => 'timestamp', 'sum' => 'double precision')
    end    .to raise_error(Errors::ElementsNotAHashError)
  end
end
