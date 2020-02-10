class CoinDeskApi
  include HTTParty
  base_uri 'api.coindesk.com'

  def initialize(type, margin, exchange_rate, cty_code='USD')
    @type = type.downcase
    @margin = margin
    @cty_code = cty_code.upcase
    @exchange_rate = exchange_rate
  end

  def get_bpi
    begin
      response = self.class.get('/v1/bpi/currentprice.json')
      btc = JSON.parse(response)
      @bcp = btc['bpi'][@cty_code]
      return @bcp
    rescue => exception
      raise
    end
  end

  def get_price
    unless %w(buy sell).include? @type
      return {
        errors: true,
        price_attributes: nil,
        message: 'Invalid transaction type'
      }
    end

    get_bpi
    computed_price = compute_price
    {
      errors: false,
      price_attributes: {
        price: computed_price,
        country_code: @cty_code,
        transaction_type: @type
      }
    }
  end

  def compute_price()
    rate_in_usd = @bcp['rate_float']&.to_f
    margin_in_usd = rate_in_usd * (@margin / 100)

    if @type === 'sell'
      adjusted_rate_in_usd = rate_in_usd - margin_in_usd
    elsif @type === 'buy'
      adjusted_rate_in_usd = rate_in_usd + margin_in_usd
    end

    price = adjusted_rate_in_usd * @exchange_rate
    price.round 2
  end
end
