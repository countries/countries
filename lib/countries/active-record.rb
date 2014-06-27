class Country < ActiveRecord::Base
  self.primary_key = "alpha2"

  after_initialize :setup_country

  def self.find(*args)
    if ISO3166::Country.find_country_by_alpha2(args.first).present?
      return self.find_or_create_by(alpha2: args.first)
    end

    # When the country doesn't exist, check if it did in the past and exists in the DB.
    # If so, destroy it and raise a normal ActiveRecord exception.
    country = super(*args)
    country.destroy! if country.present?
    super(*args)
  end

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

    @country = ISO3166::Country.new(alpha2)
  end
end
