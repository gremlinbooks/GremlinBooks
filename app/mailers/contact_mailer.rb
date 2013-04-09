class ContactMailer < ActionMailer::Base

  def contact_email(contact)
    @name = contact[:name]
    @email = contact[:email]
    @comment = contact[:comments]

    mail(:from => @email, :to => "cnowotny@gremlinbooks.com, djarmoluk@gmail.com", :subject => "Gremlin Books - Contact Form Submitted")
  end

end
