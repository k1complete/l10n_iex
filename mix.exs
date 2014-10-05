defmodule L10nIex.Mixfile do
  use Mix.Project


  def project do
    [app: :l10n_iex,
     version: "0.0.1",
     elixir: "~> 0.15.0-dev",
     compilers: Mix.compilers ++ [:po],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:exgettext]]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
#    [{:exgettext, path: "../"} ]
    [{:exgettext, git: "https://github.com/k1complete/exgettext.git"}]
  end
end
