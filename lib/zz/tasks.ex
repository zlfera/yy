defmodule Zz.Tasks do
  alias Zz.Grains.Grain, as: G
  alias Zz.Repo

  def run do
    {:ok, _} = Application.ensure_all_started(:zz)
    url1 = "http://220.248.203.59:8686/rtp/data/race/getAllRaceMarketing.jsp"
    url2 = "http://220.248.203.59:8686/rtp/data/race/getRaceMeeting.jsp?id="
    url3 = "http://220.248.203.59:8686/rtp/data/race/getRaceTacheDetail.jsp?id="

    # headers = [
    # Referer:
    #   "http://59.55.120.113:8311/web/bidPriceSpecialWatch?specialNo=1014&specialName=2019%E5%B9%B47%E6%9C%884%E6%97%A5%E5%8D%97%E6%98%8C%E5%9C%B0%E5%8C%BA%E5%B8%82%E5%8E%BF%E7%BA%A7%E5%82%A8%E5%A4%87%E7%B2%AE%E8%BD%AE%E6%8D%A2%E7%AB%9E%E4%BB%B7%E9%94%80%E5%94%AE%E4%BA%A4%E6%98%93%E4%BC%9A"
    # ]

    # url1 = "http://59.55.120.113:8311/trade/open/watchSpecial"
    url = HTTPoison.get!(url1)
    docs = Jason.decode!(url.body)

    if docs != nil do
      Enum.each(docs, fn i ->
        v1 = Enum.at(i, 0)
        market_name = Enum.at(i, 1)
        url21 = "#{url2}#{v1}"
        docs21 = Jason.decode!(HTTPoison.get!(url21).body)

        if docs21 != nil do
          v2 = Enum.at(docs21, 0)
          x = Enum.at(docs21, 3)
          x = String.to_integer(x)

          Enum.each(1..x, fn ii ->
            url31 = "#{url3}#{v2}-#{ii}"
            docs31 = Jason.decode!(HTTPoison.get!(url31).body)

            if docs31 != nil do
              Enum.each(docs31, fn d ->
                {:ok, p} = Agent.start_link(fn -> d end)

                if Enum.at(d, 11) != "A" || Enum.at(d, 11) != "B" do
                  if Enum.at(d, 11) == "G" do
                    Agent.update(p, &List.replace_at(&1, 11, "流拍"))
                  end

                  if Enum.at(d, 13) == "竞卖" do
                    Agent.update(p, &List.replace_at(&1, 13, "采购"))
                  else
                    Agent.update(p, &List.replace_at(&1, 13, "拍卖"))
                  end

                  d = Agent.get(p, & &1)

                  attr = %{
                    market_name: market_name,
                    mark_number: Enum.at(d, 1),
                    year: Enum.at(d, 2),
                    variety: Enum.at(d, 3),
                    grade: Enum.at(d, 4),
                    trade_amount: String.replace(Enum.at(d, 5), ",", ""),
                    starting_price: String.replace(Enum.at(d, 6), ",", ""),
                    latest_price: String.replace(Enum.at(d, 7), ",", ""),
                    address: Enum.at(d, 9),
                    status: Enum.at(d, 11),
                    trantype: Enum.at(d, 13)
                  }

                  changeset = G.changeset(%G{}, attr)
                  Repo.insert(changeset)
                end
              end)
            end
          end)
        end
      end)
    end
  end
end
