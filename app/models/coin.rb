class Coin
	NAMES = %w(BTC LTC ETH BCH XRP XVG TRX ADA XLM)

	def self.all
		@all_coins ||= Cryptocompare::CoinList.all
	end

	def self.names
		NAMES
	end

	def self.get_img_url(name)
		"#{all['BaseImageUrl']}#{all['Data'][name]['ImageUrl']}"
	end
end
