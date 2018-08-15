module ApplicationHelper

  def get_locale_name_by_code(location_code = nil)
    location_code_with_slash = request.path.match(/\/([A-Za-z_])+/).to_s
    code = location_code ? location_code : location_code_with_slash.slice(1..(location_code_with_slash.length-1))
    code = request.query_parameters[:locale] ? request.query_parameters[:locale] : 'en' if code.nil?
    locales = { :zh_cn => '简体中文',
      # :zh_tw => '中文(台灣正體)',
      # :zh_hk => '中文(香港繁體)',
      # :zh_mo => '中文(澳門繁體)',
      :en    => 'English'
    }
    locales[code.to_sym]
  end

  def all_locales
    locales = [
      { :zh_cn => '简体中文'},
      # { :zh_tw => '中文(台灣正體)'},
      # { :zh_hk => '中文(香港繁體)'},
      # { :zh_mo => '中文(澳門繁體)'},
      { :en => 'English'}
    ]
  end

  def change_locale(location_code)
    code = request.path.sub(/\/([A-Za-z_])+\//, "/#{location_code}/")
    code = "/#{location_code}/" unless request.path.match?(/\/([A-Za-z_])+\//)
    request.protocol + request.host_with_port + code
  end
end
