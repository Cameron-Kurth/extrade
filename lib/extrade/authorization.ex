defmodule ExTrade.Authorization do
  @moduledoc """
  Interface to the E*TRADE [Authorization API](https://apisb.etrade.com/docs/api/authorization/request_token.html#).

  More information on the OAuth workflow with E*TRADE can be found in their [Developer Guides](https://developer.etrade.com/getting-started/developer-guides).
  """
  alias ExTrade.Authorization.Worker

  @doc """
  Retrieves a request token and secret via the [Get Request Token](https://apisb.etrade.com/docs/api/authorization/request_token.html#/definition/GetRequestToken) endpoint,
  which is then stored in memory and used to construct an authorization URL.

  The returned authorization URL can be followed to authenticate with E*TRADE and
  retrieve the `verifier` code necessary to invoke `get_access_token/1`.

  The request token, and therefore the generated authorization URL, is only valid for five minutes. After that, a new one will have to be generated.
  """
  @spec get_authorization_url :: {:ok | :error, String.t()}
  def get_authorization_url do
    GenServer.call(Worker, :get_request_token_and_authorization_url)
  end

  @doc """
  Retrieves an access token and secret via the [Get Access Token](https://apisb.etrade.com/docs/api/authorization/get_access_token.html#/definition/AccessToken) endpoint using the provided `verifier` code,
  which is then stored in memory and used to construct authorization headers for all API requests.

  The access token will become "inactive" after two hours of inactivity. Using `renew_access_token/0` will reactivate the inactive access token.

  By default, all access tokens are "expired" at the end of the current calendar day, US Eastern time.
  Once the token has expired, no requests will be processed for that token until the OAuth process is repeated and a new access token is retrieved.
  """
  @spec get_access_token(String.t()) :: :ok | {:error, String.t()}
  def get_access_token(verifier) do
    with :ok <- GenServer.call(Worker, {:set_verifier, verifier}) do
      GenServer.call(Worker, :get_access_token)
    end
  end

  @doc """
  Renews the current access token and secret via the [Renew Access Token](https://apisb.etrade.com/docs/api/authorization/renew_access_token.html#/definition/RenewAccessToken) endpoint.
  """
  @spec renew_access_token :: :ok | {:error, String.t()}
  def renew_access_token do
    GenServer.call(Worker, :renew_access_token)
  end

  @doc """
  Revokes the current access token and secret via the [Revoke Access Token](https://apisb.etrade.com/docs/api/authorization/revoke_access_token.html#/definition/RevokeAccessToken) endpoint.
  """
  @spec revoke_access_token :: :ok | {:error, String.t()}
  def revoke_access_token do
    GenServer.call(Worker, :revoke_access_token)
  end

  @doc """
  Constructs an authorization header using the current access tokens stored in memory.
  """
  @spec get_authorization_header(String.t(), String.t()) :: {String.t(), String.t()}
  def get_authorization_header(method, url) do
    GenServer.call(Worker, {:get_authorization_header, method, url})
  end
end
