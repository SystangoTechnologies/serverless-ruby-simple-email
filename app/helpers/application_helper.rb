require 'base64'

module ApplicationHelper

  def get_email_configuration( recipient, sender, body, subject)
    configurations = {}
    configurations[:destination] = {to_addresses: [recipient]}
    configurations[:message] = {body: {html: {data: body}}}
    configurations[:message] = configurations[:message].merge({subject: {data: subject}})
    configurations[:source] = sender
    configurations
  end

  def get_authorization_key(authorization)
    Base64.decode64(authorization) rescue false
  end
end
