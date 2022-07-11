defmodule ExTrade.Accounts.PerformanceView do
  @moduledoc """
  A struct representing an E*TRADE [PerformanceView](https://apisb.etrade.com/docs/api/account/api-portfolio-v1.html#/definitions/PerformanceView) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :change,
    :change_percent,
    :last_trade,
    :last_trade_time,
    :days_gain,
    :total_gain,
    :total_gain_percent,
    :market_value,
    :quote_status
  ]
end
