class ContactMailer < ActionMailer::Base

  def contact_email(contact)
    @name = contact[:name]
    @email = contact[:email]
    @comment = contact[:comment]

    mail(:from => @email, :to => "cnowotny@gremlinbooks.com, djarmoluk@gmail.com", :subject => "Gremlin Books - Contact Form Submitted")
  end
  handle_asynchronously :contact_email

end
