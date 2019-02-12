defmodule DecoderRing.MixProject do
  use Mix.Project

  def project do
    [
      app: :decoder_ring,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      # mod: {DecoderRing.Application, []}
    ]
  end

  defp deps do
    [
      {:rotn, "~> 0.2.0"}
    ]
  end

  defp aliases do
    [
      test: ["test --no-start"]
    ]
  end
end
