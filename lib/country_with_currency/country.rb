class Country
  attr_reader :number, :iso, :currency, :name, :symbol
  
  # Thrown when an unknown country is requested.
  class UnknownCountry < StandardError; end
  
  # Thrown when an unknown attribute is requested.
  class UnknownAttribute < StandardError; end

  class << self
    attr_accessor :countries
    attr_reader :alpha3

    def all
      countries
    end
    
    # Define on self, since it's a class method
    def method_missing(*arguments)
      regex = arguments.first.to_s.match(/^find_by_(.*)/)
      super if !regex || $1.nil?
      @alpha3 = arguments[1]
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
  
  def initialize(data={})
    @number = data["number"]
    @iso = data["iso3"]
    @currency = data["currency"]
    @name = data["name"]
    @symbol = data["symbol"]
  end

  load_file(File.join(File.dirname(__FILE__), '..', 'data', 'countries.yaml'))
end