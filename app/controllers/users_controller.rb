class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def contacts
    @contacts = ""
    current_user.contacts.each{|contact|
      @contacts+="#{contact.name},#{contact.number}\n"
    }
    render json: @contacts, status: 200
  end

end
