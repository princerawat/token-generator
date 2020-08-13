class AccessToken < ApplicationRecord
	before_create :generate_token
	after_create :release_token
	after_create :delete_token

	# Statuses = ['active', 'released', 'unblocked', 'assigned']
	scope :available, -> { where.not(:status => 'assigned') }

	def generate_token
		while access_token = SecureRandom.urlsafe_base64(nil, false)
			break access_token if AccessToken.find_by_access_token(access_token).blank?
		end
		self.access_token = access_token
	end

	def is_expired?
		self.expires_at <= Time.now
	end

	def delete_token
		DeleteTokenWorker.perform_in(5.minutes, self.id)
	end

	def release_token
		ReleaseTokenWorker.perform_in(1.minutes, self.id)
	end
end
