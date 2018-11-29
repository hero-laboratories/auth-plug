# AuthPlug

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `auth_plug` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:auth_plug, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/auth_plug](https://hexdocs.pm/auth_plug).

Then inject AuthenticatePlug in your pipeline

```
plug AuthPlug.AuthenticatePlug, gateway_secret: "SECRET_KEY"
```

Then access user details inside your controller

```
def controller_action(conn, _) do
    conn.assigns[:user_details]
end
```