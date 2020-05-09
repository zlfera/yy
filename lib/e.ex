defmodule E do
  def e do
    url = "https://36kr.com/video"

    headers = [
      {"Accept", "application/json"},
      {"User-Agent",
       "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:50.0) Gecko/20100101 Firefox/50.0"}
    ]

    HTTPoison.get!(url, headers).body
    |> String.split("pageCallback\":\"")
    |> Enum.at(1)
    |> String.split("\",\"hasNextPage")
    |> Enum.at(0)
  end
end
