module NLRLogic

  TIMES = [{day_part: "nishanta", start: {hour: 3, minute: 36}, end: {hour: 5, minute: 59}},
           {day_part: "prataha", start: {hour: 6, minute: 00}, end: {hour: 8, minute: 23}},
           {day_part: "purvahna", start: {hour: 8, minute: 24}, end: {hour: 10, minute: 47}},
           {day_part: "madhyahna", start: {hour: 10, minute: 48}, end: {hour: 15, minute: 35}},
           {day_part: "aparahna", start: {hour: 15, minute: 36}, end: {hour: 17, minute: 59}},
           {day_part: "shayana", start: {hour: 18, minute: 00}, end: {hour: 20, minute: 23}},
           {day_part: "pradosha", start: {hour: 20, minute: 24}, end: {hour: 22, minute: 47}},
           {day_part: "nisha", start: {hour: 22, minute: 48}, end: {hour: 3, minute: 35}}]

  def self.day_minute hour, minute
    (hour * 60) + minute
  end

end
