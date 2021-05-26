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

  it 'has a day' do
    expect(@timeslot_list).to all(respond_to :day)
  end

  it 'its day should be one of: Monday, Tuesday, Wednesday, Thursday or Friday}' do
    @timeslot_list.each do |timeslot|
      expect(timeslot.day).to be_a String
      expect(VALID_DAYS).to include(timeslot.day)
    end
  end

  it 'has valid time' do
    expect(@timeslot_list).to all(respond_to :time)
  end

  it 'its time should be an Integer between 9 and 19' do
    @timeslot_list.each do |timeslot|
      expect(VALID_TIMES).to include(timeslot.time)
      expect(timeslot.time).to be_a Integer
    end
  end

  it 'raises InvalidValue if day is wrong' do
    expect { Timeslot.new(day: '', time: 19) }.to raise_error(Timeslot::InvalidValue)
  end

  it 'raises InvalidValue if time is wrong' do
    expect { Timeslot.new(day: 'Monday', time: '') }.to raise_error(Timeslot::InvalidValue)
  end
end

describe '#timeslot?' do
  include_context 'timeslots instances'

  it 'should let us check if its class is Timeslot' do
    @timeslot_list.each do |timeslot|
      expect(timeslot).to respond_to(:timeslot?)
      expect(timeslot.timeslot?).to eq(true)
    end
  end
end
