class CurrenciesController < ApplicationController
	COIN_NAMES = %w(BTC LTC ETH BCH XRP XVG TRX ADA XLM)
	def index
		response = Cryptocompare::Price.find(COIN_NAMES, 'USD')
		render json: 'Server Error' unless response

		@coin_values = get_coin_values(response)

		response = Cryptocompare::HistoDay.find('BTC', 'USD')

		@dates = get_dates(response)
		@dollar_array = get_daily_data(response)
	end

	def show
		@coin_name = params[:id].upcase
		render json: 'Server Error' unless @coin_name.in?(COIN_NAMES)
		response = Cryptocompare::Price.find(@coin_name, 'USD')

		@coin_value = response[@coin_name]['USD']

		response = Cryptocompare::HistoDay.find(@coin_name, 'USD')

		@dates = get_dates(response)
		@dollar_array = get_daily_data(response)
	end

	private

	def get_coin_values(response)
		coin_values = {}
		response.each do |name, values|
			coin_values[name] = values['USD']
		end
		coin_values
	end

	def get_dates(response)
		first_date = Time.at(response['TimeFrom']).to_date
		last_date = Time.at(response['TimeTo']).to_date
		(first_date..last_date).map { |date| date.strftime("%m/%d/%Y") }
	end

	def get_daily_data(response)
		response['Data'].map { |daily_data| daily_data['close'] }
	end
end
