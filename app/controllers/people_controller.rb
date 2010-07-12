class PeopleController < ApplicationController
  def show
    load_person
  end

  def edit
    load_person
  end

  def update
    load_person
    @person.update_attributes!(params[:person])
    redirect_to(@person, :notice => 'Person was successfully updated.')
  rescue ActiveRecord::RecordInvalid
    render :action => :edit
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(params[:person])
    @person.save!
    confirmation = url_for(:controller => :pages, :action => :invitation_requested)
    redirect_to confirmation, :status => 303
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  private
  def load_person
    @person = Person.find_active(params[:id])
  rescue PersonNotFound
    render_404
  end
end
