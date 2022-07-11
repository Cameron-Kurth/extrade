defmodule ExTrade.Accounts.ProductID do
  @moduledoc """
  A struct representing an E*TRADE [ProductId](https://apisb.etrade.com/docs/api/account/api-transaction-v1.html#/definitions/ProductId) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :symbol,
    :type_code
  ]
end
