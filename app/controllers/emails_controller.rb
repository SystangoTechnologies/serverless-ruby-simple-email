class EmailsController < ApplicationController
  include ApplicationHelper

  before_action :set_sender
  before_action :set_recipient
  before_action :set_subject
  before_action :set_body
  before_action :initialize_ses

  def send_email
    begin
      resp = @ses.send_email(get_email_configuration(@recipient, @sender, @htmlbody, @textbody, @subject))
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

    def set_recipient
      if params[:recipient].present? 
        @recipient = params[:recipient]
      else
        render json: {success: false, message: "Please pass the recipient value", status: 200}
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
      if params[:htmlbody].present? || params[:textbody].present?
        @htmlbody = params[:htmlbody]
        @textbody = params[:textbody]  
      else
        render json: {success: false, message: "Please pass the either body values", status: 200}
      end
    end


    def initialize_ses
      @ses = Aws::SES::Client.new()
    end
end
