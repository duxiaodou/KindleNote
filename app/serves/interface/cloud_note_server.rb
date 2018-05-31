class CloudNoteServe
  attr_accessor :user, :note

  def initialize
    abstract_method
  end

  def create
    abstract_method
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

  def abstract_method
    raise NotImplementedError, "#{self.class.name}:#{__method__} is an abstract base method. Implement in your subclass."
  end

  private :abstract_method
end