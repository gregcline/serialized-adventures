defmodule SerializedAdventuresWeb.StoryGroupController do
  use SerializedAdventuresWeb, :controller

  alias SerializedAdventures.Writing
  alias SerializedAdventures.Writing.StoryGroup

  plug BasicAuth,
       [use_config: {:serialized_adventures, :auth_config}]
       when action in [:new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    story_groups = Writing.list_all_story_groups()
    render(conn, "index.html", story_groups: story_groups)
  end

  def new(conn, _params) do
    changeset = Writing.change_story_group(%StoryGroup{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"story_group" => story_group_params}) do
    case Writing.create_story_group(story_group_params) do
      {:ok, story_group} ->
        conn
        |> put_flash(:info, "Story group created successfully.")
        |> redirect(to: Routes.story_group_path(conn, :show, story_group))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    story_group = Writing.get_story_group!(id)
    story_group = %{story_group | stories: Enum.sort_by(story_group.stories, & &1.display_order)}
    render(conn, "show.html", story_group: story_group)
  end

  def edit(conn, %{"id" => id}) do
    story_group = Writing.get_story_group!(id)
    changeset = Writing.change_story_group(story_group)
    render(conn, "edit.html", story_group: story_group, changeset: changeset)
  end

  def update(conn, %{"id" => id, "story_group" => story_group_params}) do
    story_group = Writing.get_story_group!(id)

    case Writing.update_story_group(story_group, story_group_params) do
      {:ok, story_group} ->
        conn
        |> put_flash(:info, "Story group updated successfully.")
        |> redirect(to: Routes.story_group_path(conn, :show, story_group))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", story_group: story_group, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    story_group = Writing.get_story_group!(id)
    {:ok, _story_group} = Writing.delete_story_group(story_group)

    conn
    |> put_flash(:info, "Story group deleted successfully.")
    |> redirect(to: Routes.story_group_path(conn, :index))
  end
end
