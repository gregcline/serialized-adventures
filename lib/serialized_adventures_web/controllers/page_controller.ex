defmodule SerializedAdventuresWeb.PageController do
  use SerializedAdventuresWeb, :controller

  alias SerializedAdventures.Writing

  def index(conn, _params) do
    groups = Writing.get_groups_by_content(:plotful)
    render(conn, "index.html", groups: groups)
  end

  def plotless(conn, _params) do
    groups = Writing.get_groups_by_content(:plotless)
    render(conn, "index.html", groups: groups)
  end
end
