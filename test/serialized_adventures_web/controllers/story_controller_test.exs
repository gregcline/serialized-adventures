defmodule SerializedAdventuresWeb.StoryControllerTest do
  use SerializedAdventuresWeb.ConnCase

  alias SerializedAdventures.Writing

  @create_attrs %{content: "some content", display_order: 42, name: "some name", published: true}
  @update_attrs %{content: "some updated content", display_order: 43, name: "some updated name", published: false}
  @invalid_attrs %{content: nil, display_order: nil, name: nil, published: nil}

  def fixture(:story) do
    {:ok, story} = Writing.create_story(@create_attrs)
    story
  end

  describe "index" do
    test "lists all stories", %{conn: conn} do
      conn = get(conn, Routes.story_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Stories"
    end
  end

  describe "new story" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.story_path(conn, :new))
      assert html_response(conn, 200) =~ "New Story"
    end
  end

  describe "create story" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.story_path(conn, :create), story: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.story_path(conn, :show, id)

      conn = get(conn, Routes.story_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Story"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.story_path(conn, :create), story: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Story"
    end
  end

  describe "edit story" do
    setup [:create_story]

    test "renders form for editing chosen story", %{conn: conn, story: story} do
      conn = get(conn, Routes.story_path(conn, :edit, story))
      assert html_response(conn, 200) =~ "Edit Story"
    end
  end

  describe "update story" do
    setup [:create_story]

    test "redirects when data is valid", %{conn: conn, story: story} do
      conn = put(conn, Routes.story_path(conn, :update, story), story: @update_attrs)
      assert redirected_to(conn) == Routes.story_path(conn, :show, story)

      conn = get(conn, Routes.story_path(conn, :show, story))
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, story: story} do
      conn = put(conn, Routes.story_path(conn, :update, story), story: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Story"
    end
  end

  describe "delete story" do
    setup [:create_story]

    test "deletes chosen story", %{conn: conn, story: story} do
      conn = delete(conn, Routes.story_path(conn, :delete, story))
      assert redirected_to(conn) == Routes.story_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.story_path(conn, :show, story))
      end
    end
  end

  defp create_story(_) do
    story = fixture(:story)
    {:ok, story: story}
  end
end
