defmodule DungeonStats.GamesTest do
  use DungeonStats.DataCase

  alias DungeonStats.Games

  describe "games" do
    alias DungeonStats.Games.Game

    import DungeonStats.GamesFixtures

    @invalid_attrs %{id: nil, name: nil, slug: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{id: 42, name: "some name", slug: "some slug"}

      assert {:ok, %Game{} = game} = Games.create_game(valid_attrs)
      assert game.id == 42
      assert game.name == "some name"
      assert game.slug == "some slug"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{id: 43, name: "some updated name", slug: "some updated slug"}

      assert {:ok, %Game{} = game} = Games.update_game(game, update_attrs)
      assert game.id == 43
      assert game.name == "some updated name"
      assert game.slug == "some updated slug"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end
end
