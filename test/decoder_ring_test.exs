defmodule DecoderRingTest do
  use ExUnit.Case

  setup do
    Application.ensure_all_started(:decoder_ring)

    on_exit fn -> Application.stop(:decoder_ring) end

    :ok
  end

  test "sets the default shift to Rot13" do
    assert :sys.get_state(DecoderRing.Server) == 13
  end

  test "encodes a message with the default shift key" do
    {:ok, cipher} = DecoderRing.encode("Bite my shiny metal ass")
    assert cipher == "Ov#r-z(-\"uv{(-zr#ny-n\"\""
  end

  test "sets the shift to a new value" do
    DecoderRing.set_shift(7)
    assert :sys.get_state(DecoderRing.Server) == 7
  end

  test "encodes the message with a non-default key when set" do
    DecoderRing.set_shift(7)

    {:ok, cipher} = DecoderRing.encode("Good news, everyone!")
    assert cipher == "Nvvk'ul z3'l}ly\"vul("
  end

  test "decodes the message with the default shift key" do
    {:ok, plaintext} = DecoderRing.decode("Z(-zn{&uvpu.")
    assert plaintext == "My manwhich!"
  end

  test "decodes the message with a non-default key when set" do
    DecoderRing.set_shift(7)

    {:ok, plaintext} = DecoderRing.decode("[ol'ihssv{' hz'jvum|zpun")
    assert plaintext == "The ballot was confusing"
  end
end
