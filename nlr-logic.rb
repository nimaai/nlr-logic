require "bundler/setup"
load "circular-list/circularlist.rb"
Bundler.require

module NLRLogic

  class DayPart
    attr_reader :name, :start
    def initialize(name: "", start: NLRTime.new(0, 0))
      @name, @start = name, start
    end
  end

  class NLRTime < ::Time
    def initialize(hour, minute)
      now = Time.now
      super(now.year, now.month, now.day, hour, minute)
    end
  end

  DAY_PARTS = CircularList.new [DayPart.new(name: "nishanta", start: NLRTime.new(3, 36)),
                                DayPart.new(name: "prataha", start: NLRTime.new(6, 0)),
                                DayPart.new(name: "purvahna", start: NLRTime.new(8, 24)),
                                DayPart.new(name: "madhyahna", start: NLRTime.new(10, 48)),
                                DayPart.new(name: "aparahna", start: NLRTime.new(15, 36)),
                                DayPart.new(name: "shayana", start: NLRTime.new(18, 0)),
                                DayPart.new(name: "pradosha", start: NLRTime.new(20, 24)),
                                DayPart.new(name: "nisha", start: NLRTime.new(22, 48))]

  class DayPart
    def following
      DAY_PARTS.fetch(Array.instance_method(:index).bind(DAY_PARTS).call(self) + 1)
    end
  end

  def self.which_day_part? hour, minute
    while NLRTime.new(hour, minute) > DAY_PARTS.current.start
      DAY_PARTS.next
    end
    DAY_PARTS.previous
  end
end
