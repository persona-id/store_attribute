require "active_record/attribute_methods"

ActiveRecord::AttributeMethods.prepend(
  Module.new do
    def attributes
      super.merge(
        self.class._local_typed_stored_attributes.each_with_object({}) do |(store_name, stored_attributes), merge_attributes|
          stored_attributes.each do |key, _cast_type|
            merge_attributes[key] = read_store_attribute(store_name, key)
          end
        end
      )
    end

    def attribute_names
      super + self.class._local_typed_stored_attributes.values.map(&:keys).flatten
    end
  end
)
