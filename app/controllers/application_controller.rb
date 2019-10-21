# frozen_string_literal: true

class ApplicationController < Jets::Controller::Base
  before_action :authorize

  require 'base64'

  private

  def authorize
    # c2VydmVybGVzcy1lbWFpbDpzZmRiMTI0YmI=
    authorization_key = Base64.decode64(request.headers['authorization']) rescue nil
    return if authorization_key == "#{ENV['API_CLIENT_ID']}:#{ENV['API_CLIENT_SECRET']}"

    render json: { message: 'Unauthorized' }, status: 401
  end
end
