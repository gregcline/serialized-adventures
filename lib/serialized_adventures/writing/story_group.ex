defmodule SerializedAdventures.Writing.StoryGroup do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias SerializedAdventures.Writing.Story


  schema "story_groups" do
    field :content_type, :string
    field :display_order, :integer
    field :image_link, SerializedAdventures.ImageLink.Type
    field :name, :string
    field :published, :boolean, default: false
    has_many :stories, Story

    timestamps()
  end

  @doc false
  def changeset(story_group, attrs) do
    story_group
    |> cast(attrs, [:name, :published, :display_order, :content_type])
    |> cast_attachments(attrs, [:image_link])
    |> validate_required([:name, :published, :display_order, :content_type])
  end
end
