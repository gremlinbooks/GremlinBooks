class ContactMailer < ActionMailer::Base
  default from: "djarmoluk@gremlinbooks.com"

  def contact_email(contact)
    @name = contact[:name]
    @email = contact[:email]
    @comment = contact[:comment]

    mail(:to => "cnowotny@gremlinbooks.com", :subject => "Gremlin Books - Contact Form Submitted")
  end

end
