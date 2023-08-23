namespace :point_task do
  desc 'ポイントのキャンペーン情報を取得する'
  task t_point_create: :environment do
    Tpoint.destroy_all
    agent = Mechanize.new
    tpage = agent.get('https://cpn.tsite.jp/list/all')
    @t_imgs = tpage.search('.list-item__img img')
    @t_links = tpage.search('.list-item__img a')
    @t_texts = tpage.search('.list-item')

    @t_texts.zip(@t_imgs, @t_links).each do |t_text, t_img, t_link|
      Tpoint.create(t_info: t_text.inner_text, t_image: t_img[:src], t_link: t_link[:href])
    end
  end

  task d_point_create: :environment do
    Dpoint.destroy_all

    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument("--disable-dev-shm-usage")
    session = Selenium::WebDriver.for(:chrome, options:)
    session.manage.timeouts.implicit_wait = 5
    session.get('https://dpoint.docomo.ne.jp/campaign/')


    @d_texts = session.find_elements(:xpath, '/html/body/div[1]/div[3]/section/ul/li/a/div[2]/div[2]/p')
    @d_imeges = session.find_elements(:xpath, '/html/body/div[1]/div[3]/section/ul/li/a/div[1]/img')
    @d_links = session.find_elements(:xpath, '/html/body/div[1]/div[3]/section/ul/li/a')
    @d_time = session.find_elements(:xpath, '/html/body/div[1]/div[3]/section/ul/li/a/div[2]/p')

    @d_texts.zip(@d_imeges, @d_links, @d_time).each do |d_text, d_img, d_link, d_time|
      Dpoint.create(d_info: d_text.text, d_image: d_img.attribute('src'), d_link: d_link.attribute('href'),
                    d_timeline: d_time.text)
    end

    session.quit
  end

  task pay_point_create: :environment do
    Paypaypoint.destroy_all
    Paypayimage.destroy_all
    agent = Mechanize.new
    paypaypage = agent.get('https://paypay.ne.jp/event/')
    @pay_links = paypaypage.search('.articleList__link')
    @pay_texts = paypaypage.search('.articleList__contents')

    @pay_texts.zip(@pay_links).each do |pay_text, pay_link|
      Paypaypoint.create(p_info: pay_text.inner_text, p_link: pay_link[:href])
    end

    # ブラウザの指定(Chrome)
   options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument("--disable-dev-shm-usage")
    session = Selenium::WebDriver.for(:chrome, options:)
    session.manage.timeouts.implicit_wait = 5
    session.get('https://dpoint.docomo.ne.jp/campaign/')

    session.get('https://paypay.ne.jp/event/')
    session.execute_script('window.scrollTo(0, 1000);')
    sleep(3)

    @pay_imgs = session.find_elements(:xpath, '/html/body/div[1]/div[3]/div[1]/div[1]/div/ul[2]/li/a/div[1]/div/img')

    @pay_imgs.each do |pay_img|
      Paypayimage.create(p_src: pay_img.attribute('src'))
    end

    @pay_imgs1 = session.find_elements(:xpath, '/html/body/div[1]/div[3]/div[1]/div[2]/div/ul/li/a/div[1]/div/img')

    if !@pay_imgs1.empty?

      @pay_imgs1.each do |pay_img|
        Paypayimage.create(p_src: pay_img.attribute('src'))
      end

    end

    session.quit
  end
end
