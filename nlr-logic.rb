require "bundler/setup"
Bundler.require

module NLRLogic

  class DayPart
    def initialize(name: "", start: NLRTime.new(0, 0))
      @name, @start_hour, @start_minute = name, start.hour, start.min
    end
  end

  class CircularListExtended < CircularList::List
    attr_accessor :arr
  end

  class NLRTime < ::Time
    def initialize(hour, minute)
      now = Time.now
      super(now.year, now.month, now.day, hour, minute)
    end
  end

  DAY_PARTS = CircularListExtended.new [DayPart.new(name: "nishanta", start: NLRTime.new(3, 36)),
                                        DayPart.new(name: "prataha", start: NLRTime.new(6, 0)),
                                        DayPart.new(name: "purvahna", start: NLRTime.new(8, 24)),
                                        DayPart.new(name: "madhyahna", start: NLRTime.new(10, 48)),
                                        DayPart.new(name: "aparahna", start: NLRTime.new(15, 36)),
                                        DayPart.new(name: "shayana", start: NLRTime.new(18, 0)),
                                        DayPart.new(name: "pradosha", start: NLRTime.new(20, 24)),
                                        DayPart.new(name: "nisha", start: NLRTime.new(22, 48))]

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

  def self.which_day_part? hour, minute
    time = NLRTime.new(hour, minute)
  end
end
