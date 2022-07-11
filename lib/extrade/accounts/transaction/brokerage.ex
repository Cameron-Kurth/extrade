defmodule ExTrade.Accounts.Brokerage do
  @moduledoc """
  A struct representing an E*TRADE [Brokerage](https://apisb.etrade.com/docs/api/account/api-transaction-v1.html#/definitions/Brokerage) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :transaction_type,
    :product,
    :quantity,
    :price,
    :settlement_currency,
    :payment_currency,
    :fee,
    :memo,
    :check_number,
    :order_number
  ]
end
