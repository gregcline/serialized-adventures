defmodule SerializedAdventures.Writing do
  @moduledoc """
  The Writing context.
  """

  import Ecto.Query, warn: false
  alias SerializedAdventures.Repo

  alias SerializedAdventures.Writing.StoryGroup
  alias SerializedAdventures.Writing.Story

  @doc """
  Returns the list of published story_groups.

  ## Examples

      iex> list_story_groups()
      [%StoryGroup{}, ...]

  """
  def list_published_story_groups do
    Repo.all(
      from g in StoryGroup,
        where: g.published == true,
        order_by: g.display_order
    )
  end

  @doc """
  Returns story all story groups
  """
  def list_all_story_groups do
    Repo.all(
      from g in StoryGroup,
        order_by: g.display_order
    )
  end

  @doc """
  Returns a list of groups by content type.
  The valid types are `:plotful` and `plotless`.
  """
  def get_groups_by_content(type) do
    content_type =
      case type do
        :plotful -> "plotful"
        :plotless -> "plotless"
      end

    Repo.all(
      from g in StoryGroup,
        where: g.content_type == ^content_type and g.published == true,
        order_by: g.display_order
    )
  end

  @doc """
  Gets the name and id of all story groups
  """
  def group_name_and_ids() do
    Repo.all(
      from g in StoryGroup,
        select: [:id, :name]
    )
  end

  @doc """
  Gets a single story_group.

  Raises `Ecto.NoResultsError` if the Story group does not exist.

  ## Examples

      iex> get_story_group!(123)
      %StoryGroup{}

      iex> get_story_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_story_group!(id) do
    Repo.one(from g in StoryGroup, where: g.id == ^id, preload: [:stories])
  end

  @doc """
  Creates a story_group.

  ## Examples

      iex> create_story_group(%{field: value})
      {:ok, %StoryGroup{}}

      iex> create_story_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_story_group(attrs \\ %{}) do
    %StoryGroup{}
    |> StoryGroup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a story_group.

  ## Examples

      iex> update_story_group(story_group, %{field: new_value})
      {:ok, %StoryGroup{}}

      iex> update_story_group(story_group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_story_group(%StoryGroup{} = story_group, attrs) do
    story_group
    |> StoryGroup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a StoryGroup.

  ## Examples

      iex> delete_story_group(story_group)
      {:ok, %StoryGroup{}}

      iex> delete_story_group(story_group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_story_group(%StoryGroup{} = story_group) do
    Repo.delete(story_group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking story_group changes.

  ## Examples

      iex> change_story_group(story_group)
      %Ecto.Changeset{source: %StoryGroup{}}

  """
  def change_story_group(%StoryGroup{} = story_group) do
    StoryGroup.changeset(story_group, %{})
  end

  alias SerializedAdventures.Writing.Story

  @doc """
  Returns the list of stories.

  ## Examples

      iex> list_stories()
      [%Story{}, ...]

  """
  def list_stories do
    Repo.all(Story)
  end

  @doc """
  Gets a single story.

  Raises `Ecto.NoResultsError` if the Story does not exist.

  ## Examples

      iex> get_story!(123)
      %Story{}

      iex> get_story!(456)
      ** (Ecto.NoResultsError)

  """
  def get_story!(id), do: Repo.get!(Story, id)

  @doc """
  gets the previous and next story ids and the story group id for a story.
  """
  def get_story_context(id) do
    story = Repo.get!(Story, id)

    group = get_story_group!(story.story_group_id)

    surrounding =
      group.stories
      |> find_surrounding_stories(id)

    %{group_id: group.id, surrounding: surrounding}
  end

  defp find_surrounding_stories(stories, story_id) do
    ordered_stories =
      stories
      |> Stream.map(fn s -> %{id: s.id, order: s.display_order} end)
      |> Enum.sort_by(& &1.order)

    case Enum.find_index(ordered_stories, &(&1.id == story_id)) do
      nil -> %{prev: nil, next: nil}
      0 -> %{prev: nil, next: Enum.at(ordered_stories, 1)}
      i -> %{prev: Enum.at(ordered_stories, i - 1), next: Enum.at(ordered_stories, i + 1)}
    end
  end

  @doc """
  Creates a story.

  ## Examples

      iex> create_story(%{field: value})
      {:ok, %Story{}}

      iex> create_story(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_story(attrs \\ %{}) do
    %Story{}
    |> Story.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a story.

  ## Examples

      iex> update_story(story, %{field: new_value})
      {:ok, %Story{}}

      iex> update_story(story, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_story(%Story{} = story, attrs) do
    story
    |> Story.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Story.

  ## Examples

      iex> delete_story(story)
      {:ok, %Story{}}

      iex> delete_story(story)
      {:error, %Ecto.Changeset{}}

  """
  def delete_story(%Story{} = story) do
    Repo.delete(story)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking story changes.

  ## Examples

      iex> change_story(story)
      %Ecto.Changeset{source: %Story{}}

  """
  def change_story(%Story{} = story) do
    Story.changeset(story, %{})
  end
end
