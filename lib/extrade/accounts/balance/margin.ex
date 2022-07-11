defmodule ExTrade.Accounts.Margin do
  @moduledoc """
  A struct representing an E*TRADE [Margin](https://apisb.etrade.com/docs/api/account/api-balance-v1.html#/definitions/Margin) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :cash_open_order_reserve,
    :margin_open_order_reserve
  ]
end
