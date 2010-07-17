module Smirk
  class Category < Client
    
    def initialize(info)
      info.each do |key, value|
        instance_variable_set("@#{key}", value)
        Category.instance_eval do
          attr_reader key.to_sym
        end
      end
    end
    
  end
end