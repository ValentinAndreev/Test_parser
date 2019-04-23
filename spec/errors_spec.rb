# frozen_string_literal: true

require 'spec_helper'
require 'errors'

RSpec.describe Errors::Validator do
  it 'validator must returns success status with right parameters' do
    expect do
      described_class.validate('sample', 'visit', 'sample.xml',
                               'id' => 'integer', 'start_at' => 'timestamp',
                               'end_at' => 'timestamp', 'sum' => 'double precision')
    end    .not_to raise_error
  end
end
