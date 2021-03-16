defmodule SignCsrWeb.PageController do
  use SignCsrWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
