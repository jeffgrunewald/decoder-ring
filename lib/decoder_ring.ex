defmodule DecoderRing do
  @moduledoc """
  A simple implementation of a GenServer using a shift-cipher encoding library.

  Intended for demonstration purposes to showcase OTP and the implementation
  of behaviours for the various commonly used GenServer callbacks.

  The top-level module wraps the public/user-facing API and delegates it to
  the server module DecoderRing.Server
  """

  @spec start(integer()) :: {:ok, pid()}
  defdelegate start(shift \\ 13), to: DecoderRing.Server, as: :start_link

  @spec set_shift(integer()) :: :ok
  defdelegate set_shift(shift), to: DecoderRing.Server, as: :set_shift

  @spec encode(String.t) :: {:ok, String.t} | {atom(), atom()}
  defdelegate encode(message), to: DecoderRing.Server, as: :encode

  @spec decode(String.t) :: {:ok, String.t}
  defdelegate decode(message), to: DecoderRing.Server, as: :decode

  @spec status() :: tuple()
  defdelegate status(), to: DecoderRing.Server, as: :status
end
