defmodule ExTrade.Accounts.Cash do
  @moduledoc """
  A struct representing an E*TRADE [Cash](https://apisb.etrade.com/docs/api/account/api-balance-v1.html#/definitions/Cash) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :funds_for_open_orders,
    :money_market_balance
  ]
end
