def hash_values_to_integers(hash)
  hash.transform_values { |value| Integer(value, exception: false) || value }
end
