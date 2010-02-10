module Smirk
  class Image < Client
    
    def initialize(session_id, info)
      info.each do |key, value|
        instance_variable_set("@#{key.downcase}", value)
        Image.instance_eval do
          attr_reader key.downcase.to_sym
        end
      end
      @session_id = session_id
    end
    
  end
end