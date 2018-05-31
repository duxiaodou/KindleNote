require  Rails.root.join('app/serves/interface/cloud_note_server.rb')

class EvernoteServe < CloudNoteServe

  attr_accessor :token, :client

  def initialize(token, user, note)
    @token = token
    @user = user
    @note = note
  end

  def client
    @client ||= EvernoteOAuth::Client.new(token: @token)
  end

  def create
    content = ''
    @note.fragments.each do |fragment|
      content += fragment.content
    end
    content += ''
    note_content = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" \
                  + "<!DOCTYPE en-note SYSTEM \"http://xml.evernote.com/pub/enml2.dtd\">" \
                  + "<en-note>#{content}</en-note>"

    evernote_note = Evernote::EDAM::Type::Note.new
    evernote_note.title = note.title
    evernote_note.content = note_content

    begin
      note = client.note_store.createNote(evernote_note)
    rescue Evernote::EDAM::Error::EDAMUserException => edue
      raise 'Something was wrong with the note data'
    rescue Evernote::EDAM::Error::EDAMNotFoundException => ednfe
      raise 'Parent Notebook GUID doesn\'t correspond to an actual notebook'
    end
    
  end

  def update
    abstract_method
  end

  def delete
    abstract_method
  end

  def share
    abstract_method
  end
end