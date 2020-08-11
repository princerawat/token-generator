class AccessTokenController < ApplicationController
	def index
		access_token = AccessToken.create
		render json: {
			success:true,
			access_token: access_token
		}
	end
end
