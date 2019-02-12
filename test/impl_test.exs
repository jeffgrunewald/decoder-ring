defmodule DecoderRing.ImplTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "to_cipher encodes a message based on the provided shift key" do
    plaintext = DecoderRing.Impl.to_cipher("the best kind of correct", 13)
    expected = {:ok, "#ur-or\"#-xv{q-|s-p|!!rp#"}

    assert plaintext == expected
  end

  test "to_plaintext decodes a message based on the provided shift key" do
    cipher = DecoderRing.Impl.to_plaintext("f|$-nyy-\"#vyy-un%r-g|vqor!t.", 13)
    expected = {:ok, "You all still have Zoidberg!"}

    assert cipher == expected
  end

  test "greets the illustrious inspiration for the rotn library" do
    actual =
      capture_io(fn ->
        DecoderRing.Impl.greeting()
      end)

    expected = "GFY, Johnson!"

    assert actual =~ expected
  end
end
