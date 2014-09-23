defmodule Schizo.Mixfile do
  use Mix.Project

  def project do
    [app: :schizo,
     version: "0.0.2",
     elixir: "~> 0.13.3",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [],
     mod: {Schizo, []}]
  end

  defp deps do
    []
  end
end
