class AccessTokenController < ApplicationController
	before_action :find_token, only: [:unblock, :delete, :keep_alive]

	def index
		token = AccessToken.create
		render json: { access_token: token.access_token, message: 'Token created in pool.' }
	end

	def assign
		token = AccessToken.available.last
		if token.present?
			token.update(status: 'assigned')
			render json: { access_token: token.access_token }
		else
			render json: {}, status: 404
		end
	end

	def unblock
		@token.update(status: 'unblocked')
		render json: { message: 'Token unblocked.' }
	end

	def keep_alive
		@token.update(keep_alive: true)
		render json: { message: 'Token status changed to keep-alive.' }
	end

	def delete
		@token.destroy
		render json: { message: 'Token deleted.' }
	end

	private

		def find_token
			@token = AccessToken.find_by_access_token(params[:access_token])
			unless @token.present?
				render json: { message: 'Token not found.' }, status: 404 and return
			end
		end
end
