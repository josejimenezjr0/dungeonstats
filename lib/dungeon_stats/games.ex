defmodule DungeonStats.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias DungeonStats.Repo

  alias DungeonStats.Games.Game

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all(Game)
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!("my_game")
      %Game{}

      iex> get_game!("not_a_game")
      ** (Ecto.NoResultsError)

  """
  def get_game!(id) when is_integer(id), do: Repo.get(Game, id)
  def get_game!(slug), do: Repo.get_by(Game, slug: slug)

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{data: %Game{}}

  """
  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end


  def subscribe(%Game{id: id}) do
    Phoenix.PubSub.subscribe(DungeonStats.PubSub, "game:#{id}")
  end

  # Send out updated game state
  def notify(%Game{id: id} = game) do
    Phoenix.PubSub.broadcast!(
      DungeonStats.PubSub,
      "game:#{id}",
      {__MODULE__, game}
    )

    game
  end

  # Send message to everyone in a game
  def message(%Game{id: id} = game, message) do
    Phoenix.PubSub.broadcast!(
      DungeonStats.PubSub,
      "game:#{id}",
      {:game_message, message}
    )

    game
  end
end
