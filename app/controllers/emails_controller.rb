# frozen_string_literal: true

class EmailsController < ApplicationController
  before_action :check_from
  before_action :check_recipients
  before_action :check_subject
  before_action :check_body
  before_action :initialize_ses

  def send_email
    @ses.send_email(email_configurations)
    render json: { message: 'Email sent!' }, status: 201
  rescue Aws::SES::Errors::ServiceError => e
    render json: { message: e }, status: 422
  end

  private

  def check_from
    return if params[:from].present?

    render json: { message: 'Please pass the from value' }, status: 400
  end

  def check_recipients
    return if params[:to].present?

    render json: { message: 'Please pass the recipients value' }, status: 400
  end

  def check_subject
    return if params[:subject].present?

    render json: { message: 'Please pass the subject value' }, status: 400
  end

  def check_body
    return if params[:textBody].present? || params[:htmlBody].present?

    render json: { message: 'Please pass the body value' }, status: 400
  end

  def initialize_ses
    @ses = AWS::SES::Base.new(region: ENV['REGION'],
                              access_key_id: ENV['ACCESS_KEY_ID'],
                              secret_access_key: ENV['SECRET_ACCESS_KEY'])
  end

  def email_configurations
    {
      from: params[:from],
      to: params[:to],
      cc: params[:cc],
      bcc: params[:bcc],
      subject: params[:subject],
      text_body: params[:textBody],
      html_body: params[:htmlBody]
    }
  end
end
