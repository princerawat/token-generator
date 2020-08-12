class DeleteTokenWorker
  include Sidekiq::Worker

  def perform(token_id)
    access_token = AccessToken.find_by_id(token_id)
    access_token.destroy if (access_token.present? && access_token.keep_alive.blank?)
  end
end
