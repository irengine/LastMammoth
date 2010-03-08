module Utility
  module ClassMethods
    # displays a random quote frou our quotes.yml
    def quote
      quotes=YAML.load_file("#{RAILS_ROOT}/config/quotes.yml")
      quotes[rand(quotes.length)]
    end
  end
end