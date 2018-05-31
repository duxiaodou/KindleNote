require  Rails.root.join('app/serves/implement/evernote_serve.rb')

class CloudNoteServeFactory

  @@platform_names = [:evernote, :qq, :youdao]

  def self.createNoteServe(platform_name, user, note)
    raise NotImplementedError, "KindleNote暂不支持#{platform_name}" unless @@platform_names.include?(platform_name.to_sym)
    raise NotImplementedError, "请绑定#{platform_name}" unless (token = user.access_tokens.where(name: platform_name).first)

    case platform_name.to_sym
      when :evernote
        EvernoteServe.new(token.access_token, user, note)
      else
        raise NotImplementedError, "KindleNote暂不支持#{platform_name}"
    end

  end
end