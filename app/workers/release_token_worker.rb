class ReleaseTokenWorker
  include Sidekiq::Worker

  def perform(token_id)
  	access_token = AccessToken.find_by_id(token_id)
  	access_token.update(status: 'released') if access_token.present?
  end
end
