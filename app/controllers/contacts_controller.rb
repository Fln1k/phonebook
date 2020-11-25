class ContactsController < ApplicationController
  before_action :require_login, except: [:index]

  def index
    if current_user
      @contacts = Contact.where(user_id: current_user.id)
    end
  end

  def new
    @contact = Contact.new
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def create
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      flash[:notice] = "Successfully created contact!"
      redirect_to root_path
    else
      flash[:alert] = "Error creating new contact!"
      render :new
    end
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update(contact_params)
      flash[:notice] = "Successfully created contact!"
      redirect_to root_path
    else
      flash[:alert] = "Error creating new contact!"
      render 'edit'
    end
  end


  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    redirect_to root_path
  end

  def update_via_file
    @updated_info = File.read(params["file"]["attachment"].path.to_s).split("\n")
    begin
      ActiveRecord::Base.transaction do
        Contact.where(:user_id => current_user.id).destroy_all
        @updated_info.each { |message|
          message = message.split(",")
          current_user.contacts.new(:name => message[0], :number => message[1].gsub(" ","")).save!
        }
      end
      flash[:notice] = "Successfully updated contacts!"
      redirect_to root_path
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error] = "Please check your file"
      redirect_to root_path
    end
  end


  private
  def contact_params
    params.require(:contact).permit(:name, :number)
  end

  def require_login
    unless user_signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_path
    end
  end
end
