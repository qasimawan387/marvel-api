defmodule MarvelApi.Utils.MarvelApiUtils do
  @endpoint "https://gateway.marvel.com/v1/public/"
  @api_key "0bce9a6c2932660f6d7cf8e2cc974ff3"
  @private_key "ea924cd502316104fe03fabf5da5f885321a57df"
  @ts "1"

  @doc """
  This function is used to get the process_url according to resource
  """
  @spec process_url(String.t()) :: String.t()
  def process_url(resource) do
    hash = get_hash() |> encypt_hash()

    @endpoint <> "#{resource}?ts=#{@ts}&apikey=#{@api_key}&hash=#{hash}"
  end

  defp get_hash do
    @ts <> @private_key <> @api_key
  end

  defp encypt_hash(string) do
    :crypto.hash(:md5, string)
    |> Base.encode16()
    |> String.downcase()
  end
end
