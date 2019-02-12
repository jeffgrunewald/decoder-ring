defmodule DecoderRing.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {DecoderRing.KeyStore, 13},
      {DecoderRing.Server, nil}
    ]

    opts = [strategy: :rest_for_one, name: DecoderRing.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
