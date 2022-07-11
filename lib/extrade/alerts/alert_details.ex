defmodule ExTrade.Alerts.AlertDetails do
  @moduledoc """
  A struct representing an E*TRADE [AlertDetailsResponse](https://apisb.etrade.com/docs/api/user/api-alert-v1.html#/definition/AlertDetailsResponse) model.

  _Note: Keys have been re-formatted for `snake_casing`. In some instances, they have also been updated for clarity and consistency._
  """
  use ExTrade

  @type t() :: %__MODULE__{}

  defstruct [
    :id,
    :create_time,
    :subject,
    :message,
    :read_time,
    :delete_time,
    :symbol,
    :next,
    :previous
  ]
end
