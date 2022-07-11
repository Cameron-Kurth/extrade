defmodule ExTrade.Accounts.Category do
  @moduledoc """
  A struct representing an E*TRADE [Category](https://apisb.etrade.com/docs/api/account/api-transaction-v1.html#/definitions/Category) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :category_id,
    :parent_id,
    :category_name,
    :parent_name
  ]
end
