require 'money'

module ISO3166
  # Optional extension which allows you to get back a Money::Currency object with all the currency info
  module CountryCurrencyMethods
    def currency
      Money::Currency.find(data['currency_code'])
    end
  end
end
