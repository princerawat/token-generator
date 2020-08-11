class AccessToken < ApplicationRecord
	before_create :generate_token
	before_create :add_expires_at

	def generate_token
		while access_token = SecureRandom.urlsafe_base64(nil, false)
			break access_token if AccessToken.find_by_access_token(access_token).blank?
		end
		self.access_token = access_token
  	end

  	def add_expires_at
  		self.expires_at = self.created_at + 1.minutes
  	end

  	def is_expired?
  		self.expires_at <= Time.now
  	end
end
