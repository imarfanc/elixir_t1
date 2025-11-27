defmodule ElixirT1Web.PageController do
  use ElixirT1Web, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
