# frozen_string_literal: true

require_relative '../lib/timeslot'

VALID_DAYS = %w[Monday Tuesday Wednesday Thursday Friday].freeze
VALID_TIMES = (9..19).to_a

shared_context 'timeslots instances' do
  before do
    @timeslot_list = Timeslot.build_unique_timeslots
  end
end

describe Timeslot do
  include_context 'timeslots instances'

  it 'has a valid day' do
    expect(@timeslot_list).to all(respond_to :day)
    @timeslot_list.each do |timeslot|
      expect(timeslot.day).to be_a String
      expect(VALID_DAYS).to include(timeslot.day)
    end
  end

  it 'has a valid time' do
    expect(@timeslot_list).to all(respond_to :time)
    @timeslot_list.each do |timeslot|
      expect(timeslot.time).to be_a Integer
      expect(VALID_TIMES).to include(timeslot.time)
    end
  end

  it 'raises InvalidValue if day is wrong' do
    expect { Timeslot.new(day: '', time: 19) }.to raise_error(Timeslot::InvalidValue)
  end

  it 'raises InvalidValue if time is wrong' do
    expect { Timeslot.new(day: 'Monday', time: '') }.to raise_error(Timeslot::InvalidValue)
  end
end
