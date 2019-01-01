defmodule SerializedAdventuresWeb.StoryGroupView do
  use SerializedAdventuresWeb, :view

  alias SerializedAdventures.ImageLink

  defp story_cover(story) do
    ImageLink.url({story.cover_image, story}, :thumb)
  end

  defp group_cover(story_group) do
    ImageLink.url({story_group.image_link, story_group}, :thumb)
  end
end
