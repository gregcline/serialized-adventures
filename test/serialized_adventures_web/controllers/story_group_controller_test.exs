defmodule SerializedAdventuresWeb.StoryGroupControllerTest do
  use SerializedAdventuresWeb.ConnCase

  alias SerializedAdventures.Writing

  @create_attrs %{content_type: "some content_type", display_order: 42, image_link: "some image_link", name: "some name", published: true}
  @update_attrs %{content_type: "some updated content_type", display_order: 43, image_link: "some updated image_link", name: "some updated name", published: false}
  @invalid_attrs %{content_type: nil, display_order: nil, image_link: nil, name: nil, published: nil}

  def fixture(:story_group) do
    {:ok, story_group} = Writing.create_story_group(@create_attrs)
    story_group
  end

  describe "index" do
    test "lists all story_groups", %{conn: conn} do
      conn = get(conn, Routes.story_group_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Story groups"
    end
  end

  describe "new story_group" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.story_group_path(conn, :new))
      assert html_response(conn, 200) =~ "New Story group"
    end
  end

  describe "create story_group" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.story_group_path(conn, :create), story_group: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.story_group_path(conn, :show, id)

      conn = get(conn, Routes.story_group_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Story group"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.story_group_path(conn, :create), story_group: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Story group"
    end
  end

  describe "edit story_group" do
    setup [:create_story_group]

    test "renders form for editing chosen story_group", %{conn: conn, story_group: story_group} do
      conn = get(conn, Routes.story_group_path(conn, :edit, story_group))
      assert html_response(conn, 200) =~ "Edit Story group"
    end
  end

  describe "update story_group" do
    setup [:create_story_group]

    test "redirects when data is valid", %{conn: conn, story_group: story_group} do
      conn = put(conn, Routes.story_group_path(conn, :update, story_group), story_group: @update_attrs)
      assert redirected_to(conn) == Routes.story_group_path(conn, :show, story_group)

      conn = get(conn, Routes.story_group_path(conn, :show, story_group))
      assert html_response(conn, 200) =~ "some updated content_type"
    end

    test "renders errors when data is invalid", %{conn: conn, story_group: story_group} do
      conn = put(conn, Routes.story_group_path(conn, :update, story_group), story_group: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Story group"
    end
  end

  describe "delete story_group" do
    setup [:create_story_group]

    test "deletes chosen story_group", %{conn: conn, story_group: story_group} do
      conn = delete(conn, Routes.story_group_path(conn, :delete, story_group))
      assert redirected_to(conn) == Routes.story_group_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.story_group_path(conn, :show, story_group))
      end
    end
  end

  defp create_story_group(_) do
    story_group = fixture(:story_group)
    {:ok, story_group: story_group}
  end
end
