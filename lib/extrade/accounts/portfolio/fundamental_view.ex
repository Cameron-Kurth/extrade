defmodule ExTrade.Accounts.FundamentalView do
  @moduledoc """
  A struct representing an E*TRADE [FundamentalView](https://apisb.etrade.com/docs/api/account/api-portfolio-v1.html#/definitions/FundamentalView) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :last_trade,
    :last_trade_time,
    :change,
    :change_percent,
    :pe_ratio,
    :eps,
    :dividend,
    :dividend_yield,
    :market_cap,
    :week_52_range,
    :quote_status
  ]
end
