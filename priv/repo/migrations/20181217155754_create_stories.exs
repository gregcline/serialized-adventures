defmodule SerializedAdventures.Repo.Migrations.CreateStories do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :name, :string
      add :content, :text
      add :published, :boolean, default: false, null: false
      add :display_order, :integer
      add :cover_image, :string
      add :story_group_id, references(:story_groups, on_delete: :nothing)

      timestamps()
    end

    create index(:stories, [:story_group_id])
  end
end
