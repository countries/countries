class Country < ActiveRecord::Base
  self.primary_key = "alpha2"

  after_initialize :setup_country

  def method_missing(method, *args, &block)
    if @country.present? && @country.respond_to?(method.to_s)
      @country.send method, *args, &block
    else
      super
    end
  end

  def respond_to?(method)
    return true if @country.present? && @country.respond_to?(method.to_s)
    super
  end

  private

  def setup_country
    raise "When creating a new record the '#{self.class.primary_key}' must be provided" if alpha2.nil?

    if File.split($0).last != 'rake'
      @country = ISO3166::Country.new(alpha2)

      raise "The country code you provided doesn't exist ('#{alpha2}'), try updating the country codes: 'rake countries:update'" if @country.nil?
      raise "Please run 'rake countries:update' to update the country codes" if version != Countries::VERSION
    end
  end
end
