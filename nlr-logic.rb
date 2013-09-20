require "bundler/setup"
Bundler.require

module NLRLogic

  DAY_PARTS = [{name: "nishanta", hour: 3, minute: 36},
               {name: "prataha", hour: 6, minute: 0},
               {name: "purvahna", hour: 8, minute: 24},
               {name: "madhyahna", hour: 10, minute: 48},
               {name: "aparahna", hour: 15, minute: 36},
               {name: "shayana", hour: 18, minute: 0},
               {name: "pradosha", hour: 20, minute: 24},
               {name: "nisha", hour: 22, minute: 48, edge: true}]

  class DayPart
    attr_reader :name, :hour, :minute, :next_index
    def initialize(options = {})
      @name = options[:name]
      @hour = options[:hour]
      @minute = options[:minute]
      @next_index = options[:edge] ? 0 : DAY_PARTS.index{|dp| dp[:name] == name} + 1
    end

    def following
      DayPart.new DAY_PARTS[next_index]
    end
  end

  class NLRTime < ::Time
    def initialize hour, minute, day = nil
      now = Time.now
      day = day ? day : Date.tomorrow.day
      super(now.year, now.month, day, hour, minute)
    end
  end

  def self.which_day_part? hour, minute
    now = NLRTime.new(hour, minute)

    DAY_PARTS.each_with_index do |day_part_info, i|
      current = DayPart.new(day_part_info)
      following = current.following
      start_time = NLRTime.new current.hour, current.minute
      end_time = NLRTime.new following.hour, following.minute, if current[:edge] then Date.tomorrow.day end

      if now.between? start_time, end_time
        current
      else
        next
      end
    end
  end
end
