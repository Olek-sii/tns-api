require 'google/apis/gmail_v1'

class GoogleApiController < ApplicationController
  before_action :authenticate_user!
  before_action :update_google_token

  def messages
    google_tokens = JSON.parse(current_user.google_tokens)
    client = Google::Apis::GmailV1::GmailService.new
    client.authorization = google_tokens['token']
    data = {q: 'from:hamburg.mysteryshopping@tns-infratest.com after:2017/11/01 older:2017/12/06'}
    messages = client.list_user_messages('me', data)
    render :json => messages
  end

  protected

  def update_google_token
    google_tokens = JSON.parse(current_user.google_tokens)
    if google_tokens['expires_at'] < Time.now.to_i
      data = {
          :client_id => Rails.application.secrets.GOOGLE_CLIENT_ID,
          :client_secret => Rails.application.secrets.GOOGLE_SECRET,
          :refresh_token => googleTokensJson['refresh_token'],
          :grant_type => 'refresh_token'
      }
      response = JSON.decode(RestClient.post 'https://accounts.google.com/o/oauth2/token', data)
      google_tokens['token'] = response['access_token']
      google_tokens['expires_at'] = response['expires_in'] + Time.now.to_i
      current_user.google_tokens = google_tokens.to_json
      current_user.save!
    end
  end
end
