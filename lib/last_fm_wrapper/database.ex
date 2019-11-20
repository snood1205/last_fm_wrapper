defmodule LastFmWrapper.Database do
  alias LastFmWrapper.{Configuration, LastFmDateTime, LastFmImage}

  @spec start(Configuration.t) :: {:error, any} | {:ok, pid}
  def start(%Configuration{
        database_name: db_name,
        database_username: "",
        database_password: ""
      }) do
    Postgrex.start_link(
      hostname: "localhost",
      database: db_name
    )
  end

  def start(%Configuration{
        database_name: db_name,
        database_username: db_user,
        database_password: db_pw
      }) do
    Postgrex.start_link(
      hostname: "localhost",
      username: db_user,
      password: db_pw,
      database: db_name
    )
  end

  @spec insert(map, pid) :: Postgrex.Result.t
  def insert(track, pid) do
    Postgrex.query!(
      pid,
      "INSERT INTO tracks (artist, album, name, listened_at, created_at, updated_at, url," <>
        "image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
      [
        track["artist"]["#text"],
        track["album"]["#text"],
        track["name"],
        LastFmDateTime.uts_to_datetime(track["date"]["uts"]),
        DateTime.utc_now(),
        DateTime.utc_now(),
        track["url"],
        LastFmImage.extralarge_url(track["image"])
      ]
    )
  end
end
