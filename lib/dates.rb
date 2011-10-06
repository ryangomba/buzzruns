##### A training year (July 1 to June 31)
##### e.g. TraingYear(2011) -> 7/1/10-6/31/11

class TrainingYear
    attr_reader :year, :period
    def initialize(end_year)
        @year = end_year
        @period = (Date.new(end_year-1, 7, 1)..Date.new(end_year, 6, 30))
    end
    def to_s
        start_year = @year - 1
        return "#{start_year}-#@year"
    end
end

def training_year_from_date(date)
    year = date.year
    if date.month >= 7 then year = year + 1 end
    TrainingYear.new(year)
end

##### A season type, e.g. cross country
##### 0: => XC, 1 => Indoor, 2 => Outdoor

season_names = ['Cross Country', 'Indoor Track', 'Outdoor Track']
season_short_names = ['XC', 'Indoor', 'Outdoor']

class SeasonKind
    attr_reader :name, :short_name
    def initialize(season_id)
        @name = season_names[season_id]
        @short_name = season_short_names[season_id]
    end
    def to_s
        return @name
    end
end

def season_kind_from_date(date)
    m = date.month
    id = 2
    if (7..11) === m
        id = 0
    elsif (12..2) === m
        id = 1
    end
    return SeasonKind.new(id)
end

##### A specific season, e.g. XC 2011

class Season
    # todo
end

def season_from_date(date)
end

