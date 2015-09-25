defmodule L10nIex.Mixfile do
  use Mix.Project
  def project do
    [app: :l10n_iex,
     version: "0.1.1",
     elixir: "~> 1.1.0-beta or ~> 1.0.0 or ~> 0.15.0-dev",
     compilers: Mix.compilers ++ [:po],
     name: "IEx_l10n",
     source_url: "https://github.com/elixir-lang/elixir",
     homepage_url: "https://elixir-lang/docs",
     docs: docs,
     deps: deps]
  end
  def abs_path(s) when is_list(s) do
    Path.join([File.cwd! | s])
  end
  def abs_path(s) do
    Path.join(File.cwd!, s)
  end
  def make_source_ref(source_dir) do
    gitdir = Path.join(source_dir, ".git")
    {shead, 0} = System.cmd("git", ["--git-dir", gitdir, 
                                    "rev-parse", "HEAD"])
    shead = String.rstrip(shead)
    {stag, 0} = System.cmd("git", ["--git-dir", gitdir, 
                                   "tag", "--points-at", shead])
    stag = String.rstrip(stag)
    case stag do
      nil -> shead
      "" -> shead
      _ -> stag
    end
  end
  def docs do 
    source_dir = "deps/elixir"
    sr = abs_path([source_dir, "lib/iex/ebin"])
#    IO.inspect File.ls(sr)
    if (File.exists?(source_dir)) do
      sref = make_source_ref(source_dir)
    else
      sref = nil
    end
    version_path = Path.join(source_dir, "VERSION")
#    IO.inspect [version_path: version_path]
    version = nil
    if (File.exists?(version_path)) do
      {:ok, version} = File.read(version_path)
    end
    [
     project: "IEx",
     app: "iex",
     version: version,
     formatter: Exgettext.HTML,
     source_root: abs_path("deps/elixir"),
     logo: "logo.png",
     logo_url: "http://elixir-lang.org/docs/logo.png",
     source_beam: sr,
     source_ref: sref,
     main: "IEx"
    ]
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
    [{:elixir, github: "elixir-lang/elixir", tag: "v1.1.0"},
     {:ex_doc, github: "elixir-lang/ex_doc"},
     {:earmark, "~> 0.1.17 or ~> 0.2", optional: true},
     {:exgettext, github: "k1complete/exgettext"}]
  end
end
