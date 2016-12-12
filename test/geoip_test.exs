defmodule GeoIPTest do
  use ExUnit.Case

  alias GeoIP.Location

  describe "lookup/1" do
    test "Returns OK" do
      assert {:ok, _} = GeoIP.lookup("8.8.8.8")
    end

    test "Returns ok with localhost" do
      assert {:ok, _} = GeoIP.lookup("localhost")
    end

    test "Returns ok using tuples" do
      assert {:ok, _} = GeoIP.lookup({8, 8, 8, 8})
    end

    test "Returns a Location" do
      assert {:ok, %Location{}} = GeoIP.lookup("8.8.8.8")
    end
  end
end
