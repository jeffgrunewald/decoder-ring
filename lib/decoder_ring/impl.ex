defmodule DecoderRing.Impl do
  @moduledoc """
  The implementation of the 'business logic' of the DecoderRing server.

  Separated from the GenServer implementation in the DecoderRing.Server module.

  These functions are intended to be called from the server module to abstract
  the business logic from the server functionality and provide a cleaner seam
  for testing purposes.
  """

  def to_cipher(plaintext, shift), do: Rotn.encode(plaintext, shift)

  def to_plaintext(cipher, shift), do: Rotn.decode(cipher, shift)

  def greeting() do
    Process.sleep(10_000)
    IO.puts("GFY, Johnson!")
  end
end
