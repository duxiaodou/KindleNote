require 'clippings'
class ParseClippingFileToNotesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    clippings_path = args.first
    user = args.second

    clipping = Clippings::Parse.new(clippings_path)
    notes = clipping.parseForNote
    notes.each do |title, note|
      book_saved = Book.where(title: note[:title].strip, author: note[:author]).first
      unless book_saved
          book_saved = Book.create!(title: note[:title].strip, author: note[:author], rating: 0)
      end

      note_saved =  user.notes.find_by(title: note[:title].strip)
      unless note_saved
          note_saved = user.notes.create(book_id: book_saved.id, title: note[:title].strip, rating: 0)
      end
      
      fragments = note[:fragment]
      fragments.each do |fragment|
        begin
          Fragment.create(note_id: note_saved.id, 
                      user_id: user.id,
                      category: fragment[:type], 
                      content: fragment[:content],
                      datetime: fragment[:date]
                      )
        rescue Exception => e
          logger.debug e
          next
        end
      end
    end
  end
end
