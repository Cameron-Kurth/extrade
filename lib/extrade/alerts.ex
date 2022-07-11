defmodule ExTrade.Alerts do
  @moduledoc """
  Interface to the E*TRADE [Alerts API](https://apisb.etrade.com/docs/api/user/api-alert-v1.html#).
  """
  alias ExTrade.{Request, Response, Utils}
  alias ExTrade.Alerts.{Alert, AlertDetails}

  @doc """
  Retrieve a list of `ExTrade.Alerts.Alert`s via the [List Alerts](https://apisb.etrade.com/docs/api/user/api-alert-v1.html#/definition/getAlertsInbox) endpoint.

  _Optional Query Parameters_
  - `:category`
  - `:count`
  - `:direction`
  - `:search`
  - `:status`
  """
  @spec list_alerts(Keyword.t()) :: {:ok, [Alert.t()]} | Response.error_t()
  def list_alerts(opts \\ []) do
    url = Request.build_url("/v1/user/alerts", opts)
    headers = Request.build_request_headers("GET", url)

    with {:ok, response} <- Request.get(url, headers) do
      module = Utils.object_name_to_module("Alert")

      response
      |> get_in(["AlertsResponse", "Alert"])
      |> Enum.map(&module.cast/1)
      |> then(&{:ok, &1})
    end
  end

  @doc """
  Retrieve a given `ExTrade.Alerts.Alert`'s `ExTrade.Alerts.AlertDetails` via the [List Alert Details](https://apisb.etrade.com/docs/api/user/api-alert-v1.html#/definition/https://apisb.etrade.com/docs/api/user/api-alert-v1.html#/definition/getAlertDetails) endpoint.

  _Optional Query Parameters_
  - `:html_tags`
  """
  @spec get_alert_details(integer(), Keyword.t()) :: {:ok, AlertDetails.t()} | Response.error_t()
  def get_alert_details(alert_id, opts \\ []) do
    url = Request.build_url("/v1/user/alerts/#{alert_id}", opts)
    headers = Request.build_request_headers("GET", url)

    with {:ok, response} <- Request.get(url, headers) do
      module = Utils.object_name_to_module("AlertDetailsResponse")

      response
      |> get_in(["AlertDetailsResponse"])
      |> module.cast()
      |> then(&{:ok, &1})
    end
  end
end
