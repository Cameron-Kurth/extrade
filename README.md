# ExTrade

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Hex version badge](https://img.shields.io/hexpm/v/extrade.svg)](https://hex.pm/packages/extrade)
[![Hex Docs](https://img.shields.io/badge/hex-docs-blue.svg)](https://hexdocs.pm/extrade/)

**WIP: Not recommended for use in any sort of production setting or with production API credentials.**

ExTrade is an Elixir client library for interacting with the [E\*TRADE API](https://developer.etrade.com/home).

## Installation

Install this package by adding `extrade` to your list of dependencies in `mix.exs`.

```elixir
def deps do
  [
    {:extrade, "~> 0.0.1"}
  ]
end
```

You can now run `mix deps.get`.

## Configuration

Within `config.exs` or within the environment specific config files (e.g. `dev.exs`) add your E\*TRADE API [credentials](https://us.etrade.com/etx/ris/apikey) and the appropriate environment (`:sandbox` for testing, `:production` for the real deal).

```elixir
config :extrade,
  api_key: "<API_KEY>",
  api_secret: "<API_SECRET",
  environment: :sandbox
```

## Usage

### OAuth

ExTrade manages current authorization state (e.g., request and access tokens) in a supervised process,
which serves as an in-memory data store for constructing the necessary "Authorization" header for each API request,
per the [OAuth 1.0](https://oauth.net/core/1.0a) specification that E\*TRADE follows.

The flow within ExTrade is as follows:

1. Generate the request token and authorization URL, all done via `ExTrade.Authorization.get_authorization_url/0`
1. Follow the URL provided from the prior step and authenticate with E\*TRADE, then note the verifier code presented.
1. Pass the verifier code to `ExTrade.Authorization.get_access_token/1`

E.g.,

```elixir
iex> ExTrade.Authorization.get_authorization_ur()
{:ok, "https://us.etrade.com/e/t/etws/authorize?key=abc&token=def"}
iex> ExTrade.Authorization.get_access_token("ZYXWV") # Retrieved from the E*TRADE Auth UI
:ok
```

At this point you are now ready to begin making API calls.

_Note_

The access token will become "inactive" after two hours of inactivity. Using `renew_access_token/0` will reactivate the inactive access token.

By default, all access tokens are "expired" at the end of the current calendar day, US Eastern time.
Once the token has expired, no requests will be processed for that token until the OAuth process is repeated and a new access token is retrieved.

### API

ExTrade will map each returned object and its nested objects into an internal struct. It does so with some opinions on key naming and will re-format keys for clarity and consistency. For example, the keys `"dividend"` and `"divYield"` will be cast to `:dividend` and `:dividend_yield`, respectively.

Currently, only the `Accounts` and `Alerts` (sans `Delete Alerts`) sections are implemented.

#### Example

```elixir
iex> ExTrade.Accounts.list_accounts()
{:ok,
 [
   %ExTrade.Accounts.Account{
     account_description: "Brokerage",
     account_id: "82314598",
     account_id_key: "dBZOKt9xDrtRSAOl4MSiiA",
     account_mode: "IRA",
     account_name: "NickName-1",
     account_status: "ACTIVE",
     account_type: "MARGIN",
     closed_date: nil,
     institution_type: "BROKERAGE",
     is_shareworks_account: false
   },
   %ExTrade.Accounts.Account{
     account_description: "Complete Savings",
     account_id: "58315636",
     account_id_key: "vQMsebA1H5WltUfDkJP48g",
     ...
   },
   ...
 ]}
```
