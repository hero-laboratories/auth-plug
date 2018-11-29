defmodule AuthPlug.MixProject do
  use Mix.Project

  def project do
    [
      app: :auth_plug,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env == :prod,
      description: description,
      package: package,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.5"},
      {:json_web_token, "~> 0.2.10"}
    ]
  end

  defp description do
    """
      Library for signing the requests off and decoding current user details
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Tomasz Pawlak", "Andrii Votiakov"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/hero-laboratories/auth-plug.git"}
    ]
  end
end
