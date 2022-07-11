defmodule ExTrade.Accounts.OptionsWatchView do
  @moduledoc """
  A struct representing an E*TRADE [OptionsWatchView](https://apisb.etrade.com/docs/api/account/api-portfolio-v1.html#/definitions/OptionsWatchView) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :base_symbol_and_price,
    :premium,
    :last_trade,
    :last_trade_time,
    :bid,
    :ask,
    :quote_status
  ]
end
