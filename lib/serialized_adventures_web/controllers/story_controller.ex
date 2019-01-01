defmodule SerializedAdventuresWeb.StoryController do
  use SerializedAdventuresWeb, :controller

  alias SerializedAdventures.Writing
  alias SerializedAdventures.Writing.Story

  plug BasicAuth,
       [use_config: {:serialized_adventures, :auth_config}]
       when action in [:index, :new, :create, :edit, :update, :delete]

  def index(conn, _params) do
    stories = Writing.list_stories()
    render(conn, "index.html", stories: stories)
  end

  def new(conn, _params) do
    changeset = Writing.change_story(%Story{})
    groups = Writing.group_name_and_ids()
    render(conn, "new.html", changeset: changeset, groups: groups)
  end

  def create(conn, %{"story" => story_params}) do
    case Writing.create_story(story_params) do
      {:ok, story} ->
        conn
        |> put_flash(:info, "Story created successfully.")
        |> redirect(to: Routes.story_path(conn, :show, story))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    id = String.to_integer(id)
    story = Writing.get_story!(id)
    context = Writing.get_story_context(id)
    render(conn, "show.html", story: story, context: context)
  end

  def edit(conn, %{"id" => id}) do
    story = Writing.get_story!(id)
    groups = Writing.group_name_and_ids()
    changeset = Writing.change_story(story)
    render(conn, "edit.html", story: story, changeset: changeset, groups: groups)
  end

  def update(conn, %{"id" => id, "story" => story_params}) do
    story = Writing.get_story!(id)

    case Writing.update_story(story, story_params) do
      {:ok, story} ->
        conn
        |> put_flash(:info, "Story updated successfully.")
        |> redirect(to: Routes.story_path(conn, :show, story))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", story: story, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    story = Writing.get_story!(id)
    {:ok, _story} = Writing.delete_story(story)

    conn
    |> put_flash(:info, "Story deleted successfully.")
    |> redirect(to: Routes.story_path(conn, :index))
  end
end
