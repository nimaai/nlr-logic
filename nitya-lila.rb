require "bundler/setup"
Bundler.require

module NityaLila

  class DayPart

    attr_reader :name, :hour, :minute, :following, :previous

    def initialize(name:, hour:, minute:, following:, previous:)

      @name = name
      @hour = hour
      @minute = minute
      @following = following
      @previous = previous

    end

  end

  class SimpleTime < ::Time

    def initialize hour, minute, day = Date.today.day
      now = Time.now
      super(now.year, now.month, day, hour, minute)
    end

  end

  class NityaLila

    class << self

      attr_accessor :nishanta, :prataha, :purvahna, :madhyahna, :aparahna, :shayana, :pradosha, :nisha

    end

    @nishanta = DayPart.new name: "nishanta", hour: 3, minute: 36, previous: "nisha", following: "prataha"
    @prataha = DayPart.new name: "prataha", hour: 6, minute: 0, previous: "nishanta", following: "purvahna"
    @purvahna = DayPart.new name: "purvahna", hour: 8, minute: 24, previous: "prataha", following: "madhyahna"
    @madhyahna = DayPart.new name: "madhyahna", hour: 10, minute: 24, previous: "purvahna", following: "aparahna"
    @aparahna = DayPart.new name: "aparahna", hour: 15, minute: 36, previous: "madhyahna", following: "shayana"
    @shayana = DayPart.new name: "shayana", hour: 18, minute: 0, previous: "aparahna", following: "pradosha"
    @pradosha = DayPart.new name: "pradosha", hour: 20, minute: 24, previous: "shayana", following: "nisha"
    @nisha = DayPart.new name: "nisha", hour: 22, minute: 48, previous: "pradosha", following: "nishanta"

    def self.find_day_part(hour, minute)

      check = lambda do |current = nil|

        current ||= nishanta
        following = send(current.following)

        current_time = SimpleTime.new hour, minute
        following_time = SimpleTime.new following.hour, following.minute, (Date.today.succ.day if following.name == "nishanta")

        if current_time < following_time
          current
        else
          check.call following
        end

      end

      check.call

    end

  end

end
