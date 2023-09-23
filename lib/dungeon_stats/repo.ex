defmodule DungeonStats.Repo do
  use Ecto.Repo,
    otp_app: :dungeon_stats,
    adapter: Ecto.Adapters.SQLite3
end
