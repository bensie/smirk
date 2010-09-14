module Smirk
  class Image < Client

    def initialize(info)
      info.each do |key, value|
        instance_variable_set("@#{key}", value)
        Image.instance_eval do
          attr_reader key.to_sym
        end
      end
    end

    def delete
      params = default_params.merge!({:method => "smugmug.images.delete", :ImageID => id})
      get(params)
    end

  end
end