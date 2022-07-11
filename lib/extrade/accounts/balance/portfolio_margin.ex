defmodule ExTrade.Accounts.PortfolioMargin do
  @moduledoc """
  A struct representing an E*TRADE [PortfolioMargin](https://apisb.etrade.com/docs/api/account/api-balance-v1.html#/definitions/PortfolioMargin) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :cash_open_order_reserve,
    :margin_open_order_reserve,
    :liquidating_equity,
    :house_excess_equity,
    :total_house_requirement,
    :excess_equity_minus_requirement,
    :total_margin_requirements,
    :available_excess_equity,
    :excess_equity,
    :open_order_reserve,
    :funds_on_hold
  ]
end
