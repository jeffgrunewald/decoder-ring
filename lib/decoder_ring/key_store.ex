defmodule DecoderRing.KeyStore do
  use GenServer

  @self __MODULE__

  # API
  def start_link(initial_key) do
    GenServer.start_link(@self, initial_key, name: @self)
  end

  def get(), do: GenServer.call(@self, {:get})

  def store(new_key), do: GenServer.cast(@self, {:store, new_key})

  # Server implementation
  def init(initial_key), do: {:ok, initial_key}

  def handle_call({:get}, _from, current_key) do
    {:reply, current_key, current_key}
  end

  def handle_cast({:store, new_key}, _current_key) do
    {:noreply, new_key}
  end
end
