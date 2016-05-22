class IndicatorFactory

  OBSERVE_CANDLE_TERM = 4.minutes
  CONTINUOUS_TREND_COUNT = 3
  ENOUGH_PRICE_MOVEMENT_TICK = 0.01

  def execute
    client = OandaAPI::Client::TokenClient.new(:practice, ENV["OANDA_API_KEY"])

    candles = client.candles( instrument: "USD_JPY",
                             granularity: "M1",
                           candle_format: "midpoint",
                                   start: OBSERVE_CANDLE_TERM.ago.utc.to_datetime.rfc3339).get

    return if candles.size == 0

    continuous_ask = 0
    continuous_bid = 0
    judgement_time = nil

    candles.each do |c|
      next unless c.complete?

      if bid_ask_trend(c) == :ask
        continuous_ask += 1
        continuous_bid = 0
      elsif bid_ask_trend(c) == :bid
        continuous_ask = 0
        continuous_bid += 1
      else
        continuous_ask = 0
        continuous_bid = 0
      end

      judgement_time = c.time
    end

    if continuous_ask >= CONTINUOUS_TREND_COUNT
      Indicator.create(trend: 'ask', signaled_at: judgement_time)
    elsif continuous_bid >= CONTINUOUS_TREND_COUNT
      Indicator.create(trend: 'bid', signaled_at: judgement_time)
    else
      Indicator.create(trend: 'none', signaled_at: judgement_time)
    end
  end

  private

  def bid_ask_trend(candle)
    return :none unless enough_price_movement?(candle)

    if candle.open_mid > candle.close_mid
      :bid
    elsif candle.open_mid < candle.close_mid
      :ask
    else
      :none
    end
  end

  def enough_price_movement?(candle)
    (candle.open_mid - candle.close_mid).abs >= ENOUGH_PRICE_MOVEMENT_TICK
  end
end
