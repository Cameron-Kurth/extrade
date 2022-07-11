defmodule ExTrade.Accounts.QuickView do
  @moduledoc """
  A struct representing an E*TRADE [QuickView](https://apisb.etrade.com/docs/api/account/api-portfolio-v1.html#/definitions/QuickView) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :last_trade,
    :last_trade_time,
    :change,
    :change_percent,
    :volume,
    :quote_status,
    :seven_day_current_yield,
    :annual_total_return,
    :weighted_average_maturity
  ]
end
