require 'pry'
class OmniauthController < Devise::OmniauthCallbacksController


    # <--- LESSON --->
    # Step Seventeen:
    # Write a method to handle assigning oauth data to user and error handling.

    def facebook
      @person = Person.create_from_provider_data(request.env['omniauth.auth'])
      if @person.persisted?
        flash[:error] = "I'm error!"
        sign_in_and_redirect @person
        set_flash_message(:notice,:success,kind: 'facebook') if is_navigational_format?
      else
        flash[:error] = 'There was a problem signing you in through Facebook. Please register or try signing in later.'
        redirect_to new_person_registration_url
      end
    end

    def github

      @person = Person.create_from_provider_data(request.env['omniauth.auth'])
      # binding.pry
      if @person.persisted?
        sign_in_and_redirect @person
        set_flash_message(:notice,:success,kind: 'github') if is_navigational_format?
      else
        flash[:error] = 'There was a problem signing you in through Github. Please register or try signing in later.'
        redirect_to new_person_registration_url
      end
    end

    def google_oauth2
      @person = Person.create_from_provider_data(request.env['omniauth.auth'])
      if @person.persisted?
        sign_in_and_redirect @person
        set_flash_message(:notice,:success,kind: 'google') if is_navigational_format?
      else
        flash[:error] = 'There was a problem signing you in through Google. Please register or try signing in later.'
        redirect_to new_person_registration_url
      end
    end

    def failure
      flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
      redirect_to new_person_registration_url
    end
  end