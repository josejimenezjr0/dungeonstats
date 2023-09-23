defmodule DungeonStatsWeb.GameLive.Master do
  use DungeonStatsWeb, :live_view

  alias DungeonStats.Games
  alias DungeonStats.Games.Game

  @impl true
  def mount(%{"slug" => _slug}, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"slug" => slug}, _, socket) do
    game = Games.get_game!(slug)
    Games.subscribe(game)

    {:noreply,
     socket
     |> assign(:game, game)}
  end

  @impl
  def handle_info({Game, game}, socket) do
    {:noreply, assign(socket, :game, game)}
  end

  def handle_info({:game_message, message}, socket) do
    {:noreply,
    socket
    |> put_flash(:info, message)}
  end

  @impl
  def handle_event("alert_minions", _, socket) do
    game = socket.assigns.game
    Games.message(game, "Hey you minions this is your dungeon master")
    {:noreply, socket}
  end
end
