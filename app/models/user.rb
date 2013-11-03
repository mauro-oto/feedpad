class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:google_oauth2]
  
  has_many :channels

  #validates :first_name, presence: true
  #validates_length_of :first_name, :maximum => 50, :message => "should be less than 50 characters"
  #validates :last_name, presence: true
  #validates_length_of :last_name, :maximum => 50, :message => "should be less than 50 characters"
  #validates :login_name, presence: true
  #validates_length_of :login_name, :maximum => 50, :message => "should be less than 50 characters"

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(login_name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20]
        )
      end
    end
  end


end
