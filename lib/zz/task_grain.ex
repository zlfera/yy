defmodule Zz.TaskGrain do
  alias Zz.Grains.Grain, as: G
  alias Zz.Repo

  def a(dqqq) do
    u = "http://59.55.120.113:8311/web/bidPriceSpecialWatch?specialNo=#{dqqq}&specialName=z"
    # uu = "http://59.55.120.113:8311/trade/open/watchSpecial"
    uu = "http://59.55.120.113:8311/trade/biddingAbout/tradeRequestListWatch"
    headers = [referer: u]
    options = [params: [specialNo: dqqq]]
    {o, url} = HTTPoison.post(uu, "", headers, options)

    if o == :ok do
      url.body |> Jason.decode!()
    else
      a(dqqq)
    end
  end

  def grain(y, yy) do
    dd = a(y)

    trantype =
      if yy == "S" do
        "拍卖"
      else
        "采购"
      end

    Enum.each(dd["row"], fn d ->
      latest_price =
        if d["statusName"] == "流拍" do
          "0"
        else
          Integer.to_string(d["matchPrice"])
        end

      attr = %{
        market_name: "guojia",
        mark_number: d["REQUESTALIAS"],
        year: "0",
        variety: d["VARIETYNAME"],
        grade: d["GRADENAME"],
        trade_amount: Integer.to_string(d["NUM"]),
        starting_price: Integer.to_string(d["PRICE"]),
        latest_price: latest_price,
        address: d["BUYDEPOTNAME"],
        status: d["statusName"],
        trantype: trantype
      }

      changeset = G.changeset(%G{}, attr)
      Repo.insert(changeset)
    end)
  end
end
