module URLHelper

  def link_translate(lang)
    current_URI = URI(current_page.url)
                  .to_s
                  .split('/')

    if I18n.locale != I18n.default_locale
      current_URI.shift(2)
      current_URI = current_URI.join('/')
    else
      current_URI.shift(1)
      current_URI = current_URI.join('/')
    end

    return link_to data.languages.send(lang.to_s),
    if lang === I18n.default_locale
      config[:host] + '/' + I18n.translate!("paths.#{current_page.data.title}", locale: lang)
    else
      config[:host] + '/' + lang.to_s + '/' + I18n.translate!("paths.#{current_page.data.title}", locale: lang)
    end
  end

end
