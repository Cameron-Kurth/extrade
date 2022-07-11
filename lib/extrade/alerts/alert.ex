defmodule ExTrade.Alerts.Alert do
  @moduledoc """
  A struct representing an E*TRADE [Alert](https://apisb.etrade.com/docs/api/user/api-alert-v1.html#/definition/Alert) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :id,
    :create_time,
    :subject,
    :status
  ]
end
