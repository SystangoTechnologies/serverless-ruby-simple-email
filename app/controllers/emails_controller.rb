# frozen_string_literal: true

class EmailsController < ApplicationController
  before_action :check_sender
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

  def check_sender
    return if params[:sender].present?

    render json: { message: 'Please pass the sender value' }, status: 400
  end

  def check_recipients
    return if params[:to_addresses].present?

    render json: { message: 'Please pass the recipients value' }, status: 400
  end

  def check_subject
    return if params[:subject].present?

    render json: { message: 'Please pass the subject value' }, status: 400
  end

  def check_body
    return if params[:text_body].present? || params[:html_body].present?

    render json: { message: 'Please pass the body value' }, status: 400
  end

  def initialize_ses
    @ses = Aws::SES::Client.new(
      region: ENV['REGION'],
      access_key_id: ENV['ACCESS_KEY_ID'],
      secret_access_key: ENV['SECRET_ACCESS_KEY']
    )
  end

  def email_configurations
    {
      destination: {
        to_addresses: params[:to_addresses],
        cc_addresses: params[:cc_addresses],
        bcc_addresses: params[:bcc_addresses]
      },
      message: {
        body: {
          html: {
            data: params[:html_body] || ''
          },
          text: {
            data: params[:text_body] || ''
          }
        },
        subject: {
          data: params[:subject]
        }
      },
      source: params[:sender]
    }
  end
end
