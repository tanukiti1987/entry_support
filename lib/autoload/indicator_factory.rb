class IndicatorFactory
  def self.execute
    Indicator.create(trend: 'ask', signaled_at: Time.now)
  end
end
