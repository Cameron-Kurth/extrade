defmodule ExTrade.Authorization.Worker do
  @moduledoc false
  use GenServer
  require Logger
  alias ExTrade.{Request, Response}
  alias ExTrade.Authorization.Store

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(_) do
    Process.flag(:sensitive, true)
    state = Store.get()
    {:ok, state}
  end

  @impl true
  def handle_call(:get_request_token_and_authorization_url, _from, state) do
    case get_request_token(state) do
      {:ok, %{"oauth_token" => request_token, "oauth_token_secret" => request_token_secret}} ->
        new_state =
          state
          |> Map.put(:access_token, request_token)
          |> Map.put(:access_token_secret, request_token_secret)
          |> tap(&Store.update/1)

        authorization_url = build_authorize_url(new_state)
        {:reply, {:ok, authorization_url}, new_state}

      {:error, _} ->
        {:reply, {:error, "Failed to initiate OAuth flow"}, state}
    end
  end

  @impl true
  def handle_call({:set_verifier, verifier}, _from, state) do
    new_state =
      state
      |> Map.put(:verifier, verifier)
      |> tap(&Store.update/1)

    {:reply, :ok, new_state}
  end

  @impl true
  def handle_call(:get_access_token, _from, state) do
    case get_access_token(state) do
      {:ok, %{"oauth_token" => access_token, "oauth_token_secret" => access_token_secret}} ->
        new_state =
          state
          |> Map.put(:access_token, access_token)
          |> Map.put(:access_token_secret, access_token_secret)
          |> tap(&Store.update/1)

        {:reply, :ok, new_state}

      {:error, _} ->
        {:reply, {:error, "Failed to fetch access token"}, state}
    end
  end

  @impl true
  def handle_call(:renew_access_token, _from, state) do
    case renew_access_token(state) do
      {:ok, _} ->
        {:reply, :ok, state}

      {:error, _} ->
        {:reply, {:error, "Failed to renew access token"}, state}
    end
  end

  @impl true
  def handle_call(:revoke_access_token, _from, state) do
    case revoke_access_token(state) do
      {:ok, _} ->
        new_state =
          state
          |> Map.put(:access_token, nil)
          |> Map.put(:access_token_secret, nil)
          |> Map.put(:verifier, nil)
          |> tap(&Store.update/1)

        {:reply, :ok, new_state}

      {:error, _} ->
        {:reply, {:error, "Failed to revoke access token"}, state}
    end
  end

  @impl true
  def handle_call({:get_authorization_header, method, url}, _from, state) do
    creds = build_signature_credentials(state, :access)
    header = generate_authorization_header(method, url, [], creds)
    {:reply, header, state}
  end

  @spec get_request_token(map()) :: Response.t()
  def get_request_token(state) do
    url = Request.get_base_url() <> "/oauth/request_token"
    oauth_params = [{"oauth_callback", "oob"}]
    creds = build_signature_credentials(state, :request)
    header = generate_authorization_header("GET", url, oauth_params, creds)

    Request.get(url, [header])
  end

  @spec get_access_token(map()) :: Response.t()
  def get_access_token(%{verifier: verifier} = state) do
    url = Request.get_base_url() <> "/oauth/access_token"
    oauth_params = [{"oauth_verifier", verifier}]
    creds = build_signature_credentials(state, :access)
    header = generate_authorization_header("GET", url, oauth_params, creds)

    Request.get(url, [header])
  end

  @spec renew_access_token(map()) :: Response.t()
  def renew_access_token(state) do
    url = Request.get_base_url() <> "/oauth/renew_access_token"
    creds = build_signature_credentials(state, :access)
    header = generate_authorization_header("GET", url, [], creds)

    Request.get(url, [header])
  end

  @spec revoke_access_token(map()) :: Response.t()
  def revoke_access_token(state) do
    url = Request.get_base_url() <> "/oauth/revoke_access_token"
    creds = build_signature_credentials(state, :access)
    header = generate_authorization_header("GET", url, [], creds)

    Request.get(url, [header])
  end

  @spec build_authorize_url(map()) :: String.t()
  def build_authorize_url(%{consumer_key: consumer_key, access_token: request_token}) do
    params = %{key: consumer_key, token: request_token}

    Request.get_authorization_url()
    |> URI.parse()
    |> Map.put(:query, URI.encode_query(params))
    |> to_string()
  end

  @spec build_signature_credentials(map(), :access | :request) :: OAuther.Credentials.t()
  def build_signature_credentials(state, :request) do
    OAuther.credentials(
      consumer_key: state.consumer_key,
      consumer_secret: state.consumer_secret
    )
  end

  def build_signature_credentials(state, :access) do
    OAuther.credentials(
      consumer_key: state.consumer_key,
      consumer_secret: state.consumer_secret,
      token: state.access_token,
      token_secret: state.access_token_secret
    )
  end

  @spec generate_authorization_header(
          String.t(),
          String.t() | URI.t(),
          [{String.t(), String.t()}],
          OAuther.Credentials.t()
        ) :: {String.t(), String.t()}
  defp generate_authorization_header(verb, url, oauth_params, creds) do
    verb
    |> OAuther.sign(url, oauth_params, creds)
    |> OAuther.header()
    |> elem(0)
  end
end
