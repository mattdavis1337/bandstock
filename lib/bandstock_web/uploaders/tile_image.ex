defmodule BandstockWeb.TileImage do
  use Arc.Definition
  use Arc.Ecto.Definition
  def __storage, do: Arc.Storage.Local

  @versions [:original, :thumb]
  @extension_whitelist ~w(.jpg .jpeg .gif .png)

  def acl(:thumb, _), do: :public_read

  def transform(:thumb, _) do
    {:convert, ~s(-strip -thumbnail 150x200 -background black -gravity center -extent 150x200 -format png -limit area 10MB -limit disk 100MB), :png}
  end

  def transform(:original, _) do
    {:convert, "-strip -thumbnail 600x800 -background black -gravity center -extent 600x800 -format png -limit area 10MB -limit disk 100MB", :png}
  end

  def validate({file, _}) do
    IO.puts("Validate")
    file_extension = file.file_name |> Path.extname |> String.downcase
    Enum.member?(@extension_whitelist, file_extension)
  end

  def filename(version, {file, scope}) do
    {file_name, file_ext} = String.split_at(file.file_name, -String.length(Path.extname(file.file_name)));
    "#{file_name}_#{version}"
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  def storage_dir(_, {file, tile}) do
    "priv/static/uploads/tileimages/"
  end
end
