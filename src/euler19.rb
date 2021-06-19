# Counting Sundays

# Problem 19
# You are given the following information, but you may prefer to do some 
# research for yourself.

# 1 Jan 1900 was a Monday.
# Thirty days has September,
# April, June and November.
# All the rest have thirty-one,
# Saving February alone,
# Which has twenty-eight, rain or shine.
# And on leap years, twenty-nine.
# A leap year occurs on any year evenly divisible by 4, but not on a century 
# unless it is divisible by 400.
# How many Sundays fell on the first of the month during the twentieth century 
# (1 Jan 1901 to 31 Dec 2000)?

# There's probably a very easy to do this with a library, but it seemed more
# fun to roll my own classes. I don't normally write this many classes in my
# own code, but with a calendar, it feels right somehow.

class Integer
  # considered making a year class, but seemed dumb just to check for leap
  # leap years. Might be fun to make a sort of year "God Object" that held
  # months that held weeks and days, etc. Seems like overkill, though,
  # especially since this is already feeling like overkill.
  def leap_year? # Fun Fact: Can't use question marks in stand-alone methods
    self % 4 == 0 and (self % 100 != 0 or self % 400 == 0)
  end
end

class Month
  attr_accessor :month, :year, :days

  @@months = {
    January: {"days": 31},
    February: {"days": 28},
    March: {"days": 31},
    April: {"days": 30},
    May: {"days": 31},
    June: {"days": 30},
    July: {"days": 31},
    August: {"days": 31},
    September: {"days": 30},
    October: {"days": 31},
    November: {"days": 30},
    December: {"days": 31}
  }
  
  def initialize(month, year)
    self.month = month
    self.year = year
    if month == :February and year.leap_year?
      self.days = 29 
    else 
      self.days = @@months[month][:days]
    end
  end

  def index()
    @@months.keys.find_index(self.month)
  end

  def next()
    month = @@months.keys[(self.index() + 1) % 12]
    
    if self.month == :December
      year = self.year + 1  
    else 
      year = self.year
    end

    self.class.new(month, year)
  end
end

class Day
  attr_accessor :monthday, :month, :year, :weekday

  @@weekdays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ]

  def initialize(monthday, month, year, weekday)
    self.monthday = monthday
    self.month = Month.new(month, year)
    self.year = year
    self.weekday = weekday 
  end

  def next_weekday()
    @@weekdays[(@@weekdays.find_index(self.weekday) + 1) % @@weekdays.length]
  end

  def next()
    monthday = (self.monthday + 1) % self.month.days
    if monthday == 0
      month = self.month.next()
      monthday = 1
    else
      month = self.month
    end

    year = month.year
    weekday = self.next_weekday()

    self.class.new(monthday, month.month, year, weekday) 
  end
end

day = Day.new(1, :January, 1900, "Monday")
count = 0
until day.year == 2000
  count += 1 if day.monthday == 1 and day.weekday == "Sunday"
  day = day.next()
end

# Lol. If you just used common sense "(12 * 100) / 7" and rounded down, you'd 
# be exactly correct.

p count 