defmodule DungeonStatsWeb.GameLive.Show do
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
     |> assign(:page_title, page_title(socket.assigns.live_action))
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

  defp page_title(:show), do: "Show Game"
  defp page_title(:edit), do: "Edit Game"
end
