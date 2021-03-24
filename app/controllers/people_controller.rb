require 'pry'
class PeopleController < ApplicationController
  before_action :authenticate_person!,only: [:edit, :update]
  before_action :check_authorization, only: [:edit,:update]
  before_action :set_person

  def show
  end

  def edit
  end

  def update
    @person.update(person_params)
    #  binding.pry
    if @person.valid?
      redirect_to @person
    else
      flash.now[:alert]="Something went wrong. Please try again"
      render :edit
    end
    #   pry.inspect

  end
  private

  def check_authorization
    unless current_person.id ==params[:id].to_i
      redirect_to home_url
    end
  end
  def set_person
    @person =Person.find(params[:id])
  end
  def person_params
    params.require(:person).permit(:avatar)
  end
end
