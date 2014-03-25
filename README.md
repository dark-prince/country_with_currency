# CountryWithCurrency

Provides a helper to get a country list along with ISO 3166-1 code, country number, currency code and currency symbol by following ISO 3166 country list.

## Installation

Add this line to your application's Gemfile:

    gem 'country_with_currency'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install country_with_currency

## Basic Usage

To get all countries:

    Country.all
    => [#<Country:0xa1b6e80 @number="004", @iso="AFG", @currency="AFN", @name="Afghanistan", @symbol="Af">,...]


## Attribute-Based Finder

You can lookup a country or an array of countries using any of the data attributes via the find_by_attribute dynamic finder:

    Country.find_by_name('United States')
    => [#<Country:0xa1b8a00 @number="840", @iso="USA", @currency="USD", @name="United States", @symbol="$">]
    Country.find_by_iso('USA')
    => [#<Country:0xa1b8a00 @number="840", @iso="USA", @currency="USD", @name="United States", @symbol="$">]
    Country.find_by_currency('INR')
    => [#<Country:0xa1b43c4 @number="356", @iso="IND", @currency="INR", @name="India", @symbol="Rs.">]
    Country.find_by_number(840)
    => [#<Country:0x8b64a10 @number="840", @iso="USA", @currency="USD", @name="United States", @symbol="$">]


## Contributing

1. Fork it ( http://github.com/dark-prince/country_with_currency/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request