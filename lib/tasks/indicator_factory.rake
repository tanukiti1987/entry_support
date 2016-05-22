namespace :indicator_factory do
  desc "Make indicator"
  task make: :environment do
    IndicatorFactory.execute
  end
end
