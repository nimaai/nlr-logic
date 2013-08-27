require "date"
require "pry"

module NLRLogic

  DAY_PARTS = [{name: "nishanta", start_hour: 3, start_minute: 36},
               {name: "prataha", start_hour: 6, start_minute: 00},
               {name: "purvahna", start_hour: 8, start_minute: 24},
               {name: "madhyahna", start_hour: 10, start_minute: 48},
               {name: "aparahna", start_hour: 15, start_minute: 36},
               {name: "shayana", start_hour: 18, start_minute: 00},
               {name: "pradosha", start_hour: 20, start_minute: 24},
               {name: "nisha", start_hour: 22, start_minute: 48}]

  class NLRTime < ::Time
    def initialize(hour, minute)
      now = Time.now
      super(now.year, now.month, now.day, hour, minute)
    end
  end

  def self.which_day_part? hour, minute
    t = NLRTime.new hour, minute
    DAY_PARTS.each_with_index do |day_part, i|
      if t.between? NLRTime.new(day_part[:start_hour], day_part[:start_minute]),
                    NLRTime.new(DAY_PARTS[i + 1][:start_hour], DAY_PARTS[i + 1][:start_minute])
        return day_part[:name]
      else next end
    end
  end

end
