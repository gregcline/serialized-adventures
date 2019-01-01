defmodule SerializedAdventuresWeb.PageView do
  use SerializedAdventuresWeb, :view
  alias SerializedAdventures.ImageLink

  defp cover_image(story_group) do
    ImageLink.url({story_group.image_link, story_group}, :thumb)
  end
end
