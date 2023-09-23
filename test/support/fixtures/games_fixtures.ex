defmodule DungeonStats.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DungeonStats.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        id: 42,
        name: "some name",
        slug: "some slug"
      })
      |> DungeonStats.Games.create_game()

    game
  end
end
