defmodule ExTrade.Accounts.Product do
  @moduledoc """
  A struct representing an E*TRADE [Product](https://apisb.etrade.com/docs/api/account/api-transaction-v1.html#/definitions/Product) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :symbol,
    :security_type,
    :security_sub_type,
    :option_type,
    :expiry_year,
    :expiry_month,
    :expiry_day,
    :expiry_type,
    :strike_price,
    :product_id
  ]
end
