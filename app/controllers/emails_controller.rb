class EmailsController < ApplicationController
  include ApplicationHelper

  before_action :set_sender
  before_action :set_recipients
  before_action :set_subject
  before_action :set_body
  before_action :initialize_ses

  def send_email
    begin
      @recipients.uniq.each do |recipient|
        resp = @ses.send_email(get_email_configuration(recipient, @sender, @body, @subject))
      end
      render json: {success: true, message: "Email sent!", status: 200}
    rescue Aws::SES::Errors::ServiceError => error
      render json: {success: false, message: error, status: 200}
    end
  end

  private
    
    def set_sender
      if params[:sender].present? 
        @sender = params[:sender]
      else
        render json: {success: false, message: "Please pass the sender value", status: 200}
      end
    end

    def set_recipients
      if params[:recipients].present? 
        @recipients = params[:recipients]
      else
        render json: {success: false, message: "Please pass the recipients value", status: 200}
      end
    end

    def set_subject
      if params[:subject].present? 
        @subject = params[:subject]
      else
        render json: {success: false, message: "Please pass the subject value", status: 200}
      end
    end

    def set_body
      if params[:body].present?
        @body = params[:body]
      else
        render json: {success: false, message: "Please pass the body value", status: 200}
      end
    end


    def initialize_ses
      @ses = Aws::SES::Client.new()
    end
end
