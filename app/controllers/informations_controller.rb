class InformationsController < ApplicationController
  def index
    agent = Mechanize.new
    paypaypage = agent.get('https://paypay.ne.jp/event/')
    @pay_imgs = paypaypage.search('.articleList__image')
    @pay_links = paypaypage.search('.articleList__link')
    @pay_texts = paypaypage.search('.articleList__contents')

    tpage = agent.get('https://cpn.tsite.jp/list/all')
    @t_imgs = tpage.search('.list-item__img img')
    @t_links = tpage.search('.list-item__img a')
    @t_texts = tpage.search('.list-item')

    rakutenpage = agent.get('https://pointcard.rakuten.co.jp/campaign/#ongoing')
    @rakuten_imgs = rakutenpage.search('.Campaign__img')
    @rakuten_links = rakutenpage.search('.Campaign__contents')
    @rakuten_texts = rakutenpage.search('.Campaign__details div')
  end
end
