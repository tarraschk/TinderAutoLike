# -*- encoding : utf-8 -*-
class ContactForm < MailForm::Base

  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attribute :subject,      :validate => true
  attribute :message

  def headers
    {
      :subject => @subject,
      :to => "maxime@argaus.fr",
      :from => @email
    }
  end
end
