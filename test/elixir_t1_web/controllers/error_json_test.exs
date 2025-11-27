defmodule ElixirT1Web.ErrorJSONTest do
  use ElixirT1Web.ConnCase, async: true

  test "renders 404" do
    assert ElixirT1Web.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert ElixirT1Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
