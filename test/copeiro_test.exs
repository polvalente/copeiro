defmodule CopeiroTest do
  use ExUnit.Case
  doctest Copeiro

  require Copeiro
  import Copeiro

  describe "assert_lists - operator: in -" do
    test "contains pattern" do
      assert_lists([%{a: 1}] in [%{a: 1, b: 1}, %{a: 2, b: 2}])
    end

    test "pattern not present" do
      assert_lists([%{a: 3, b: 1}] in [%{a: 1, b: 1}, %{a: 2, b: 2}])
    rescue
      error in [ExUnit.AssertionError] ->
        assert "could not match patterns: %{a: 3, b: 1}" <> _ = error.message
    end

    test "able to match custom patterns" do
      value = 2
      assert_lists([%{a: _, b: ^value}] in [%{a: 1, b: 1}, %{a: 2, b: 2}])
    end

    test "return all missing patterns" do
      assert_lists([{3, _}, {2, 2}] in [{1, 2}, {2, 3}])
    rescue
      error in [ExUnit.AssertionError] ->
        assert "could not match patterns: {3, _}, {2, 2}" <> _ = error.message
    end
  end
end
