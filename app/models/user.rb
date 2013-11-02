class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:google_oauth2]

  validates :first_name, presence: true
  validates_length_of :first_name, :maximum => 50, :message => "should be less than 50 characters"
  validates :last_name, presence: true
  validates_length_of :last_name, :maximum => 50, :message => "should be less than 50 characters"
  validates :login_name, presence: true
  validates_length_of :login_name, :maximum => 50, :message => "should be less than 50 characters"

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.create(login_name: data["name"],
	    		   email: data["email"],
	    		   password: Devise.friendly_token[0,20],
	    		   first_name: data["givenname"],
	    		   last_name: data["familyname"]
	    		  )
    end
    user
  end


end
