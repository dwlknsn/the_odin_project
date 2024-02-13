def stock_picker(prices)
  max_profit = 0
  optimal_purchase_day = 0
  optimal_purchase_price = 0
  optimal_sale_day = 0
  optimal_sale_price = 0

  prices.each_with_index do |purchase_price, x|
    prices.each_with_index do |sale_price, y|
      next if y <= x

      profit = sale_price - purchase_price

      if profit > max_profit
        max_profit = profit
        optimal_purchase_day = x
        optimal_purchase_price = purchase_price
        optimal_sale_day = y
        optimal_sale_price = sale_price
      end
    end
  end

  # p "Buy on day #{optimal_purchase_day} for $#{optimal_purchase_price}"
  # p "Sell on day #{optimal_sale_day} for $#{optimal_sale_price}"
  # p "For a max profit of $#{max_profit}"

  [optimal_purchase_day, optimal_sale_day]
end
