class ContactMailer < ActionMailer::Base

  def contact_email(contact)
    @name = contact[:name]
    @email = contact[:email]
    @comment = contact[:comment]

    mail(:from => "djarmoluk@gremlinbooks.com", :to => "cnowotny@gremlinbooks.com", :subject => "Gremlin Books - Contact Form Submitted")
  end
  #handle_asynchronously :contact_email

end
