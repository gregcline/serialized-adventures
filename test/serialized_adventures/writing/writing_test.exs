defmodule SerializedAdventures.WritingTest do
  use SerializedAdventures.DataCase

  alias SerializedAdventures.Writing

  describe "story_groups" do
    alias SerializedAdventures.Writing.StoryGroup

    @valid_attrs %{content_type: "some content_type", display_order: 42, image_link: "some image_link", name: "some name", published: true}
    @update_attrs %{content_type: "some updated content_type", display_order: 43, image_link: "some updated image_link", name: "some updated name", published: false}
    @invalid_attrs %{content_type: nil, display_order: nil, image_link: nil, name: nil, published: nil}

    def story_group_fixture(attrs \\ %{}) do
      {:ok, story_group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Writing.create_story_group()

      story_group
    end

    test "list_story_groups/0 returns all story_groups" do
      story_group = story_group_fixture()
      assert Writing.list_story_groups() == [story_group]
    end

    test "get_story_group!/1 returns the story_group with given id" do
      story_group = story_group_fixture()
      assert Writing.get_story_group!(story_group.id) == story_group
    end

    test "create_story_group/1 with valid data creates a story_group" do
      assert {:ok, %StoryGroup{} = story_group} = Writing.create_story_group(@valid_attrs)
      assert story_group.content_type == "some content_type"
      assert story_group.display_order == 42
      assert story_group.image_link == "some image_link"
      assert story_group.name == "some name"
      assert story_group.published == true
    end

    test "create_story_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Writing.create_story_group(@invalid_attrs)
    end

    test "update_story_group/2 with valid data updates the story_group" do
      story_group = story_group_fixture()
      assert {:ok, %StoryGroup{} = story_group} = Writing.update_story_group(story_group, @update_attrs)
      assert story_group.content_type == "some updated content_type"
      assert story_group.display_order == 43
      assert story_group.image_link == "some updated image_link"
      assert story_group.name == "some updated name"
      assert story_group.published == false
    end

    test "update_story_group/2 with invalid data returns error changeset" do
      story_group = story_group_fixture()
      assert {:error, %Ecto.Changeset{}} = Writing.update_story_group(story_group, @invalid_attrs)
      assert story_group == Writing.get_story_group!(story_group.id)
    end

    test "delete_story_group/1 deletes the story_group" do
      story_group = story_group_fixture()
      assert {:ok, %StoryGroup{}} = Writing.delete_story_group(story_group)
      assert_raise Ecto.NoResultsError, fn -> Writing.get_story_group!(story_group.id) end
    end

    test "change_story_group/1 returns a story_group changeset" do
      story_group = story_group_fixture()
      assert %Ecto.Changeset{} = Writing.change_story_group(story_group)
    end
  end

  describe "stories" do
    alias SerializedAdventures.Writing.Story

    @valid_attrs %{content: "some content", display_order: 42, name: "some name", published: true}
    @update_attrs %{content: "some updated content", display_order: 43, name: "some updated name", published: false}
    @invalid_attrs %{content: nil, display_order: nil, name: nil, published: nil}

    def story_fixture(attrs \\ %{}) do
      {:ok, story} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Writing.create_story()

      story
    end

    test "list_stories/0 returns all stories" do
      story = story_fixture()
      assert Writing.list_stories() == [story]
    end

    test "get_story!/1 returns the story with given id" do
      story = story_fixture()
      assert Writing.get_story!(story.id) == story
    end

    test "create_story/1 with valid data creates a story" do
      assert {:ok, %Story{} = story} = Writing.create_story(@valid_attrs)
      assert story.content == "some content"
      assert story.display_order == 42
      assert story.name == "some name"
      assert story.published == true
    end

    test "create_story/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Writing.create_story(@invalid_attrs)
    end

    test "update_story/2 with valid data updates the story" do
      story = story_fixture()
      assert {:ok, %Story{} = story} = Writing.update_story(story, @update_attrs)
      assert story.content == "some updated content"
      assert story.display_order == 43
      assert story.name == "some updated name"
      assert story.published == false
    end

    test "update_story/2 with invalid data returns error changeset" do
      story = story_fixture()
      assert {:error, %Ecto.Changeset{}} = Writing.update_story(story, @invalid_attrs)
      assert story == Writing.get_story!(story.id)
    end

    test "delete_story/1 deletes the story" do
      story = story_fixture()
      assert {:ok, %Story{}} = Writing.delete_story(story)
      assert_raise Ecto.NoResultsError, fn -> Writing.get_story!(story.id) end
    end

    test "change_story/1 returns a story changeset" do
      story = story_fixture()
      assert %Ecto.Changeset{} = Writing.change_story(story)
    end
  end
end
