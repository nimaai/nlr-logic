require "bundler/setup"
Bundler.require

module NLRLogic

  class DayPart
    def initialize(name: "", start_hour: 0, start_minute: 0)
      @name, @start_hour, @start_minute = name, start_hour, start_minute
    end
  end

  class CircularListExtended < CircularList::List
    attr_accessor :arr
  end

  DAY_PARTS = CircularListExtended.new [DayPart.new(name: "nishanta", start_hour: 3, start_minute: 36),
                                        DayPart.new(name: "prataha", start_hour: 6, start_minute: 00),
                                        DayPart.new(name: "purvahna", start_hour: 8, start_minute: 24),
                                        DayPart.new(name: "madhyahna", start_hour: 10, start_minute: 48),
                                        DayPart.new(name: "aparahna", start_hour: 15, start_minute: 36),
                                        DayPart.new(name: "shayana", start_hour: 18, start_minute: 00),
                                        DayPart.new(name: "pradosha", start_hour: 20, start_minute: 24),
                                        DayPart.new(name: "nisha", start_hour: 22, start_minute: 48)]

  class DayPart
    attr_reader :name, :next_day_part, :start_hour, :start_minute

    def next_day_part
      DAY_PARTS.fetch_next(DAY_PARTS.arr.index {|day_part| day_part.name == name})
    end

    def end_hour
      next_day_part.start_hour
    end

    def end_minute
      next_day_part.start_minute
    end
  end

  class NLRTime < ::Time
    def initialize(hour, minute)
      now = Time.now
      super(now.year, now.month, now.day, hour, minute)
    end
  end

  def self.which_day_part? hour, minute
    time = NLRTime.new hour, minute
    DAY_PARTS.each_with_index do |day_part, i|
      next_day_part = DAY_PARTS[i + 1]
      if next_day_part.nil? or time.between? NLRTime.new(day_part[:start_hour], day_part[:start_minute]), NLRTime.new(next_day_part[:start_hour], next_day_part[:start_minute])
        return day_part[:name]
      else
        next
      end
    end
  end
end
