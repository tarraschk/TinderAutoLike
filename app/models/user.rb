class User < ActiveRecord::Base
  has_secure_password
  before_save { self.login = login.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  validates :firstname, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  # Le login est l'adresse mail.
  validates :login, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # user will be able to edit her profile without providing password
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password, :allow_blank => true

  # you may also need to set the required length
  validates_length_of :password, :within => 6..40, :allow_blank => true

  #validates :password, presence: true, length: { minimum: 6 }
  #validates :password_confirmation, presence: true

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def full_name
    if self.name.nil?
      return self.login
    end
    self.firstname.capitalize + " " + self.name.capitalize
  end

  def email
    self.login
  end

  private
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

end
