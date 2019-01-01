defmodule SerializedAdventures.Story do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias SerializedAdventures.Story
  alias SerializedAdventures.Repo


  schema "stories" do
    field :content, :string
    field :name, :string
    field :published, :boolean, default: false
    field :display_order, :integer
    field :story_group_id, :id

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:name, :content, :published, :display_order, :story_group_id])
    |> validate_required([:name, :content, :published, :display_order, :story_group_id])
  end

  def insert(changeset) do
    Repo.insert(changeset)
  end

  def get_by_id(id) do
    Repo.one(from s in Story, where: s.id == ^id)
  end

  def update(story) do
    changeset = change(get_by_id(story.id), story)
    Repo.update(changeset)
  end
end
