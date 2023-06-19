class InformationsController < ApplicationController
  def index
    agent = Mechanize.new
    tpage = agent.get('https://cpn.tsite.jp/list/all')
    @t_imgs = tpage.search('.list-item__img img')
    @t_links = tpage.search('.list-item__img a')
    @t_texts = tpage.search('.list-item')

    paypaypage = agent.get('https://paypay.ne.jp/event/')
    @pay_links = paypaypage.search('.articleList__link')
    @pay_texts = paypaypage.search('.articleList__contents')
    @pay_imgs = paypaypage.search('.articleList__image')

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    session = Selenium::WebDriver.for(:chrome, options:)
    session.manage.timeouts.implicit_wait = 30

    session.get('https://dpoint.docomo.ne.jp/campaign/')

    @d_texts = session.find_elements(:xpath, '/html/body/div[1]/div[3]/section/ul/li/a/div[2]/div[2]/p')
    @d_imeges = session.find_elements(:xpath, '/html/body/div[1]/div[3]/section/ul/li/a/div[1]/img')
    @d_links = session.find_elements(:xpath, '/html/body/div[1]/div[3]/section/ul/li/a')

    # ブラウザの指定(Chrome)
    # options = Selenium::WebDriver::Chrome::Options.new
    # options.add_argument('--headless')
    # session = Selenium::WebDriver.for :chrome
    # session.manage.timeouts.implicit_wait = 30

    # session.get('https://paypay.ne.jp/event/')

    # source  = session.find_element(:xpath, '//*[@id="pagetop"]/div[3]/div[1]/div[1]/div/ul[2]/li[11]/a/div[1]/div/img')
    # target  = session.find_element(:xpath, '//*[@id="pagetop"]/div[3]/div[1]/div[1]/div/ul[2]/li[11]/a/div[1]/div/img')

    # 3秒間待機して移動前の位置を確認
    # sleep(3)
    # 移動元の要素をドラッグし移動先の要素へカーソル移動
    # session.action.click_and_hold(source).move_to(target).perform

    # source  = session.find_element(:xpath, '//*[@id="previous"]/div')
    # target  = session.find_element(:xpath, '//*[@id="previous"]/div')

    # 3秒間待機して移動前の位置を確認
    # sleep(3)
    # 移動元の要素をドラッグし移動先の要素へカーソル移動
    # session.action.click_and_hold(source).move_to(target).perform

    # @pay_imgs =  session.find_elements(:xpath, '//*[@id="pagetop"]/div[3]/div[1]/div[1]/div/ul[2]/li/a/div[1]/div/img')
  end
end
