defmodule ExTrade.Accounts.RealTimeValues do
  @moduledoc """
  A struct representing an E*TRADE [RealTimeValues](https://apisb.etrade.com/docs/api/account/api-balance-v1.html#/definitions/RealTimeValues) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :total_account_value,
    :net_market_value,
    :net_market_value_long,
    :net_market_value_short,
    :total_long_value
  ]
end
