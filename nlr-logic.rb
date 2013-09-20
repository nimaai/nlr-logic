require "bundler/setup"
load "circular-list/circularlist.rb"
Bundler.require

module NLRLogic

  class DayPart
    attr_reader :name, :start, :next_index
    def initialize(options = {})
      @name = options[:name]
      @start = options[:start]
      @next_index = options[:next_index]
    end
  end

  class NLRTime < ::Time
    def initialize(hour, minute)
      now = Time.now
      super(now.year, now.month, now.day, hour, minute)
    end
  end

  DAY_PARTS = [DayPart.new(name: "nishanta", start: NLRTime.new(3, 36), next_index: 1),
               DayPart.new(name: "prataha", start: NLRTime.new(6, 0), next_index: 2),
               DayPart.new(name: "purvahna", start: NLRTime.new(8, 24), next_index: 3),
               DayPart.new(name: "madhyahna", start: NLRTime.new(10, 48), next_index: 4),
               DayPart.new(name: "aparahna", start: NLRTime.new(15, 36), next_index: 5),
               DayPart.new(name: "shayana", start: NLRTime.new(18, 0), next_index: 6),
               DayPart.new(name: "pradosha", start: NLRTime.new(20, 24), next_index: 7),
               DayPart.new(name: "nisha", start: NLRTime.new(22, 48), next_index: 0)]

  class DayPart
    def following
      DAY_PARTS[next_index]
    end
  end

  def self.which_day_part? hour, minute
    while NLRTime.new(hour, minute) > DAY_PARTS.current.start
      DAY_PARTS.next
    end
    DAY_PARTS.previous
  end
end
