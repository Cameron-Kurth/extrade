defmodule ExTrade.Accounts.Transaction do
  @moduledoc """
  A struct representing an E*TRADE Transaction model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :transaction_id,
    :account_id,
    :transaction_date,
    :post_date,
    :amount,
    :description,
    :description_2,
    :transaction_type,
    :memo,
    :image_flag,
    :institution_type,
    :category,
    :brokerage,
    :details_uri
  ]
end
