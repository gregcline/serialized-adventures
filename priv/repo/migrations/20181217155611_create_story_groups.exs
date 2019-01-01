defmodule SerializedAdventures.Repo.Migrations.CreateStoryGroups do
  use Ecto.Migration

  def change do
    create table(:story_groups) do
      add :name, :string
      add :published, :boolean, default: false, null: false
      add :display_order, :integer
      add :content_type, :string
      add :image_link, :string

      timestamps()
    end

  end
end
