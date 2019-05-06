module ApplicationHelper

  def get_email_configuration( recipient, sender, htmlbody, textbody, subject)
    configurations = {}
    configurations[:destination] = {to_addresses: [recipient]}
    configurations[:message] = {body: {html: {data: htmlbody}}} if htmlbody.present?
    if textbody.present? && configurations[:message].present?
      configurations[:message][:body].merge({text: {data: textbody}})
    elsif textbody.present? && !configurations[:message].present?
      configurations[:message] = {body: {text: {data: textbody}}}
    end
    configurations[:message] = configurations[:message].merge({subject: {data: subject}})
    configurations[:source] = sender
    configurations
  end
end
