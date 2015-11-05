require 'countries'

class Country < ISO3166::Country
  def to_s
    name
  end
end
