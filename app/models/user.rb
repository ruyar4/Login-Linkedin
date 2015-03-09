class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:linkedin]

  def self.find_for_linkedin_oauth(auth, signed_in_resource=nil)      
	  user = User.where(provider: auth.provider, uid: auth.uid).first       
	  # The User was found in our database    
	  return user if user    
	  # Check if the User is already registered without Facebook      
	  user = User.where(email: auth.info.nickname).first 
	  return user if user
	  create! do |user|
	  	user.name = auth.info.name
	  	user.uid = auth.uid
	  	user.provider = auth.provider
	  	user.photo = auth.info.image
	  	user.email = auth.info.email
	  	user.headline = auth.info.headline
	  	user.industry = auth.info.industry
	  	user.location = auth.info.location
	  	user.description = auth.info.description
	  	user.urls = auth.info.urls
	  	user.password = Devise.friendly_token[0,20]

	    #name: auth.info.name,
	    #provider: auth.provider, uid: auth.uid,
	    #email: auth.info.nickname,
	    #password: Devise.friendly_token[0,20],  
	  	#photo: auth.info.image)
	  end
   end
end
