class Types::PriceType < Types::BaseObject
  description "The price object"

  field :price, Float, null: false
  field :country_code, String, null: false
  field :transaction_type, String, null: false
end
