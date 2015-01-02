# -*- encoding : utf-8 -*-
class ContactController < ApplicationController
  before_filter :leftbar

  def leftbar
    @current_page = "contact"
  end

  def index
    render 'show_form'
  end

  def create

    form_valid_bool = true

    if request.POST[:email].blank?
      flash.now[:danger] = "Please fill the email field."
      form_valid_bool = false
    else
      dest_email = request.POST[:email]
    end

    if request.POST[:subject].blank?
      flash.now[:danger] = "Please fill the subject field."
      form_valid_bool = false
    else
      dest_subject = request.POST[:subject]
    end

    if request.POST[:content].blank?
      flash.now[:danger] = "Please fill the message field."
      form_valid_bool = false
    else
      dest_message = request.POST[:content]
    end

    if form_valid_bool
      c = ContactForm.new(:email => dest_email, :subject => dest_subject, :message => dest_message)
      puts c.errors.inspect
      puts c.errors.full_messages
      if c.deliver
        flash.now[:success] = "Message sent with succes."
        render 'create_form'
      else
        flash.now[:danger] = "Error, please try again later."
        render 'show_form'
      end
    else
      render 'show_form'
    end

  end

end
