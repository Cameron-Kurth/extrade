defmodule ExTrade.Request do
  @moduledoc false
  alias ExTrade.{Authorization, Response}

  @authorization_url "https://us.etrade.com/e/t/etws/authorize"
  @production_url "https://api.etrade.com"
  @sandbox_url "https://apisb.etrade.com"

  @spec get_base_url :: String.t()
  def get_base_url() do
    if get_env() == :production, do: @production_url, else: @sandbox_url
  end

  @spec get_authorization_url :: String.t()
  def get_authorization_url(), do: @authorization_url

  @spec build_url(String.t(), keyword()) :: String.t()
  def build_url(endpoint, params \\ []) do
    (get_base_url() <> endpoint)
    |> URI.parse()
    |> Map.put(:query, params |> format_query_params() |> URI.encode_query())
    |> to_string()
  end

  @spec build_request_headers(String.t(), String.t()) :: [{String.t(), String.t()}]
  def build_request_headers(method, url) do
    auth_header = Authorization.get_authorization_header(method, url)
    [auth_header] ++ [{"Accept", "application/json"}]
  end

  @spec get(String.t(), [{String.t(), String.t()}]) :: Response.t()
  def get(url, headers \\ []) do
    url
    |> HTTPoison.get(headers, ssl_opts())
    |> Response.handle_response()
  end

  @spec delete(String.t(), [{String.t(), String.t()}]) :: Response.t()
  def delete(url, headers \\ []) do
    url
    |> HTTPoison.delete(headers, ssl_opts())
    |> Response.handle_response()
  end

  @spec format_query_params(keyword()) :: keyword()
  defp format_query_params(opts), do: Enum.map(opts, &format_query_param/1)

  @spec format_query_param({atom(), any}) :: {atom(), any}
  defp format_query_param({key, value}), do: {camelize(key), value}

  @spec camelize(atom()) :: atom()
  defp camelize(atom) do
    {first, rest} = atom |> Atom.to_string() |> Macro.camelize() |> String.split_at(1)
    first |> String.downcase() |> Kernel.<>(rest) |> String.to_atom()
  end

  defp ssl_opts do
    [
      ssl: [
        ciphers:
          :ssl.cipher_suites(:all, :"tlsv1.2") ++
            [%{key_exchange: :rsa, cipher: :aes_256_cbc, mac: :sha256}],
        verify: :verify_peer,
        cacertfile: :certifi.cacertfile(),
        depth: 3,
        customize_hostname_check: [
          match_fun: :public_key.pkix_verify_hostname_match_fun(:https)
        ]
      ]
    ]
  end

  defp get_env, do: Application.get_env(:extrade, :environment, :sandbox)
end
