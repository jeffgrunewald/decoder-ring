defmodule DecoderRing.Server do
  @moduledoc """
  The GenServer implementation of the Rot/Shift-Cipher server.

  Actual implementation of the GenServer callback functions and the true
  public-facing API of the server, intended to be called from the root module:
  DecoderRing.

  Business logic is abstracted into the DecoderRing.Impl module to separate
  functionality specific to the app from implementation of the GenServer itself.

  This is particularly pedantic, but this is for demonstration purposes and is
  just generally good practice.
  """

  use GenServer
  alias DecoderRing.Impl

  @self __MODULE__

  # API
  def start_link(_), do: GenServer.start_link(@self, nil, name: @self)

  def set_shift(shift), do: GenServer.cast(@self, {:set_shift, shift})

  def encode("johnson"), do: GenServer.cast(@self, {:greeting, :ignored})

  def encode("t@xation15th3ft") do
    Process.whereis(@self)
    |> Process.exit(:kill)
  end

  def encode(message), do: GenServer.call(@self, {:encode, message})

  def decode(message), do: GenServer.call(@self, {:decode, message})

  def status(), do: :sys.get_status(@self)

  # Server Implementation
  def init(_) do
    {:ok, DecoderRing.KeyStore.get()}
  end

  def handle_call({:encode, message}, _from, shift) do
    {:reply, Impl.to_cipher(message, shift), shift}
  end

  def handle_call({:decode, cipher}, _from, shift) do
    {:reply, Impl.to_plaintext(cipher, shift), shift}
  end

  def handle_cast({:set_shift, new_shift}, _current_shift) do
    DecoderRing.KeyStore.store(new_shift)
    {:noreply, new_shift}
  end

  def handle_cast({:greeting, _}, shift) do
    Impl.greeting()
    {:noreply, shift}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "Current shift is #{inspect state}"}]]
  end
end
