defmodule Zz.TaskGrain do
  alias Zz.Grains.Grain, as: G
  alias Zz.Repo

  def a(dqqq \\ 1121) do
    u = "http://59.55.120.113:8311/web/bidPriceSpecialWatch?specialNo=#{dqqq}&specialName=z"
    uu = "http://59.55.120.113:8311/trade/open/watchSpecial"
    headers = [referer: u]
    {o, url} = HTTPoison.post(uu, "", headers)

    if o == :ok do
      url.body |> Jason.decode!()
    else
      a(dqqq)
    end
  end

  def grain(y, pid) do
    dd = a(y)

    case dd["success"] do
      "true" ->
        Enum.each(dd["rows"], fn jj ->
          if !String.match?(jj["varietyName"], ~r/玉米|麦|油|豆/) do
            # j(jj, dd, pid)
          end
        end)

        grain(y, pid)

      "false" ->
        rows = Agent.get(pid, & &1)

        if !Enum.empty?(rows) do
          Enum.each(rows, fn attr ->
            changeset = G.changeset(%G{}, attr)
            Repo.insert(changeset)
            Agent.update(pid, &Enum.drop_every(&1, 1))
          end)
        end

      _ ->
        Process.sleep(5000)
        grain(y, pid)
    end
  end
end
