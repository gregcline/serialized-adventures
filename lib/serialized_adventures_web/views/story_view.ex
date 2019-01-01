defmodule SerializedAdventuresWeb.StoryView do
  use SerializedAdventuresWeb, :view

  defp markdown(nil) do
    ""
  end

  defp markdown(body) do
    body
    |> Earmark.as_html!()
    |> raw
  end

  defp group_select(groups) do
    Enum.map(groups, fn group ->
      try do
        {String.to_existing_atom(group.name), group.id}
      rescue
        ArgumentError ->
          {String.to_atom(group.name), group.id}
      end
    end)
  end

  defp submit_name() do
    [
      "Go Scraw, go!",
      "Heck yeah, a new story bud.",
      "Submit Story.",
      "Some other funny line."
    ]
    |> Enum.random()
  end
end
