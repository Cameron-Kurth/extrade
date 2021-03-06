defmodule ExTrade.Accounts.CompleteView do
  @moduledoc """
  A struct representing an E*TRADE [CompleteView](https://apisb.etrade.com/docs/api/account/api-portfolio-v1.html#/definitions/CompleteView) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :price_adjusted_flag,
    :price,
    :adjusted_price,
    :change,
    :change_percent,
    :previous_close,
    :adjusted_previous_close,
    :volume,
    :last_trade,
    :last_trade_time,
    :adjusted_last_trade,
    :symbol_description,
    :performance_1_month,
    :performance_3_month,
    :performance_6_month,
    :performance_12_month,
    :previous_day_volume,
    :volume_10_day,
    :beta,
    :stochastic_volatility_10_day_avg,
    :stochastic_volatility_20_day_avg,
    :stochastic_volatility_1_month_avg,
    :stochastic_volatility_2_month_avg,
    :stochastic_volatility_3_month_avg,
    :stochastic_volatility_4_month_avg,
    :stochastic_volatility_6_month_avg,
    :week_52_high,
    :week_52_low,
    :week_52_range,
    :market_cap,
    :days_range,
    :delta_52_week_high,
    :delta_52_week_low,
    :currency,
    :exchange,
    :is_marginable,
    :bid,
    :ask,
    :bid_ask_spread,
    :bid_size,
    :ask_size,
    :open,
    :delta,
    :gamma,
    :implied_volatility_percent,
    :rho,
    :theta,
    :vega,
    :premium,
    :days_to_expiration,
    :intrinsic_value,
    :open_interest,
    :options_adjusted_flag,
    :deliverables,
    :option_multiplier,
    :base_symbol_and_price,
    :estimated_earnings,
    :pe_ratio,
    :eps,
    :annual_dividend,
    :dividend,
    :dividend_yield,
    :dividend_payable_date,
    :ex_dividend_date,
    :cusip,
    :quote_status
  ]
end
