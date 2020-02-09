require "rails_helper"

RSpec.describe Types::PriceType do
  describe "price attributes when selling" do

    let(:sell_query) do
      %(query {
        calculatePrice(
          type: "sell"
          margin: 0.1
          exchangeRate: 363.5
        ) {
          price
        }
      })
    end

    let(:bad_query) do
      %(query {
        calculatePrice(
          type: "cello"
          margin: 0.1
          exchangeRate: 363.5
        ) {
          price
        }
      })
    end

    subject(:sell_result) do
      CoinBoxSchema.execute(sell_query).as_json
    end

    subject(:bad_result) do
      CoinBoxSchema.execute(query).as_json
    end

    it "returns all price attributes" do
      expect(sell_result.dig("data", "calculatePrice")).to include({
        'price' => a_value > 3000000
      })
    end
  end

  describe "price attributes when buying" do
    let(:buy_query) do
      %(query {
        calculatePrice(
          type: "buy"
          margin: 0.1
          exchangeRate: 363.5
        ) {
          price
        }
      })
    end

    subject(:buy_result) do
      CoinBoxSchema.execute(buy_query).as_json
    end

    it "returns all price attributes" do
      expect(buy_result.dig("data", "calculatePrice")).to include({
        'price' => a_value < 4000000
      })
    end
  end

  describe "no price attributes with bad transaction types" do
    let(:bad_query) do
      %(query {
        calculatePrice(
          type: "buying"
          margin: 0.1
          exchangeRate: 363.5
        ) {
          price
        }
      })
    end

    subject(:bad_result) do
      CoinBoxSchema.execute(bad_query).as_json
    end

    it "returns no price attributes" do
      expect(bad_result.dig("data")).to eq nil
    end
  end
end
