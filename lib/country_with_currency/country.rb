class Country
  # @return [Integer] Returns the Number of country.
  # @return [Integer] Returns the ISO 3166-1 code of country.
  # @return [Integer] Returns the ISO 4217 code of currency.
  # @return [String] Returns the Name of country.
  # @return [String] Returns the Symbol of currency.
  attr_reader :number, :iso, :currency, :name, :symbol
  
  # Thrown when an unknown country is requested.
  class UnknownCountry < StandardError; end
  
  # Thrown when an unknown attribute is requested.
  class UnknownAttribute < StandardError; end

  def initialize(data={})
    @number = data["number"]
    @iso = data["iso3"]
    @currency = data["currency"]
    @name = data["name"]
    @symbol = data["symbol"]
  end

  class << self
    attr_accessor :countries
    attr_reader :alpha3

    # All countries
    #
    # Example
    #
    # Country.all
    #
    # Returns an Array with value of all country objects
    def all
      countries
    end
    
    # Overriding method_missing to add dynamic finders.
    #
    # *args - standard method_missing arguments
    #
    # Examples
    #
    # Country.find_by_iso("USA")
    # Country.find_by_name("United States")
    #
    # Returns an Array with value of country object/objects
    # Raises NoMethodError if couldn't find a method
    # Raises UnknownAttribute if couldn't find a valid attribute
    # Raises UnknownCountry if couldn't find any country object
    def method_missing(*args)
      regex = args.first.to_s.match(/^find_by_(.*)/)
      # Check if the missing method applies to Country
      super if !regex || $1.nil?
      @alpha3 = args[1]
      select_by($1, @alpha3)
    end

    private

    def load_file(file)
      YAML.load_file(file).each do |code, options|
        add(new(code))
      end
    end

    def add(country)
      self.countries ||= []
      self.countries << country
    end
    
    def select_by(attribute, val)
      attr, value = parse_attributes(attribute.downcase, (val ? val.downcase : val))

      data = countries.select { |c| c.send(attr.to_sym).downcase == value }
      validate(data)
      data
    end
    
    def parse_attributes(attr, val)
      raise UnknownAttribute, "Invalid attribute '#{attr}'." unless [:number, :iso, :currency, :name, :symbol].include?(attr.to_sym)

      [attr, val]
    end
    
    # Raise errors for invalid countries.
    def validate(country)
      raise UnknownCountry, "Country not found." if country.empty?
    end

    private :new
  end

  load_file(File.join(File.dirname(__FILE__), '..', 'data', 'countries.yaml'))
end