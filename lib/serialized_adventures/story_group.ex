defmodule SerializedAdventures.StoryGroup do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias SerializedAdventures.StoryGroup
  alias SerializedAdventures.Repo
  alias SerializedAdventures.Story


  schema "story_groups" do
    field :name, :string
    field :published, :boolean, default: false
    field :display_order, :integer
    field :content_type, :string
    field :image_link, :string
    has_many :stories, Story

    timestamps()
  end

  @doc false
  def changeset(story_group, attrs) do
    story_group
    |> cast(attrs, [:name, :published, :display_order, :content_type])
    |> validate_required([:name, :published, :display_order, :content_type])
  end

  def published_group_names() do
    Repo.all(from g in StoryGroup,
      where: g.published == true,
      select: [:id, :name])
  end

  def get_group_by_content(type) do
    content_type = case type do
      :plotful -> "plotful"
      :plotless -> "plotless"
    end
    Repo.all(from g in StoryGroup,
              where: g.content_type == ^content_type
              and g.published == true)
  end

  def insert(group) do
    Repo.insert(group)
  end

  def get_by_id(id) do
    Repo.one(from g in StoryGroup, where: g.id == ^id, preload: [:stories])
  end
end
