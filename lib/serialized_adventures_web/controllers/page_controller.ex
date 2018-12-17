defmodule SerializedAdventuresWeb.PageController do
  use SerializedAdventuresWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
