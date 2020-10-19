module Transformations
  module Hash
    module_function

    def except(hash, keys)
      hash.reject do |key, _|
        keys.include?(key)
      end
    end

    def slice(hash, keys)
      hash.select do |key, _|
        keys.include?(key)
      end
    end
  end
end
