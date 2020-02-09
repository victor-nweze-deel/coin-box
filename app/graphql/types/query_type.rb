module Types
  class QueryType < Types::BaseObject
    field :calculate_price, Types::PriceType, null: false do
      description "Price calculator"
      argument :type, String, required: true
      argument :margin, Float, required: true
      argument :exchange_rate, Float, required: true
    end
    def calculate_price(type:, margin:, exchange_rate:)
      response = CoinDeskApi.new(type, margin, exchange_rate).get_price
      raise GraphQL::ExecutionError.new('Invalid transaction type entered') \
        if response[:errors]
      response[:price_attributes]
    end
  end
end
