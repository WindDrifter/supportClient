class Request < ActiveRecord::Base


  validates :name, presence: {message: "Must be present"}
  validates :email, presence: {message: "Must be present"}
  validates :message, presence: {message: "Must be present"}
  validates :department, presence: {message: "Must be present"}


#format takes regular expression
  #validates :email, format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  after_initialize :set_defaults

  before_save :capitalize_name
  #scope :recent, lambda { order(:created_at).reverse_order}
  scope :status, ->  { order(:done).reverse_order}
    def self.status
      order(:done).reverse_order # getting recent question

    end
    def self.ten
      limit(10)
    end

    def self.searchFor(item)


      serach_term = "%#{item}%"
      where(["name ILIKE :term OR message ILIKE :term",{term: serach_term}])

    end


  private


  def set_defaults
    self.done ||=0
  end
  def capitalize_name
    self.name.capitalize!
  end
end
