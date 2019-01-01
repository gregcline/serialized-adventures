defmodule SerializedAdventures.Writing.Story do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "stories" do
    field :content, :string
    field :display_order, :integer
    field :name, :string
    field :published, :boolean, default: false
    field :cover_image, SerializedAdventures.ImageLink.Type
    field :story_group_id, :id

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:content, :name, :published, :display_order, :story_group_id])
    |> cast_attachments(attrs, [:cover_image])
    |> validate_required([:name, :published, :display_order, :story_group_id])
  end

  defp strip_unsafe_body(model, %{"content" => nil}) do
    model
  end

  defp strip_unsafe_body(model, %{"content" => body}) do
    {:safe, clean_body} = Phoenix.HTML.html_escape(body)
    model |> put_change(:content, clean_body)
  end

  defp strip_unsafe_body(model, _) do
    model
  end
end
