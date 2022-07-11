defmodule ExTrade.Accounts.Account do
  @moduledoc """
  A struct representing an E*TRADE [Account](https://apisb.etrade.com/docs/api/account/api-account-v1.html#/definitions/Account) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :account_id,
    :account_id_key,
    :account_mode,
    :account_description,
    :account_name,
    :account_type,
    :account_status,
    :institution_type,
    :closed_date,
    :is_shareworks_account
  ]
end
