class ApplicationController < ActionController::Base

  protect_from_forgery

  layout proc{ |c| c.request.xhr? ? false : "application" }

  before_filter :set_user
  before_filter :set_topic
  before_filter :get_views

  def set_scope
    @scope = if (@affiliation == "staff" and params[:all])
      @multi = true
      Event.scoped
    else
      @multi = false
      @topic.events
    end
  end

  def get_date
    if params[:date]
      if params[:date].kind_of? Hash
        Time.gm(*[:year,:month,:day].map{|x| params[:date][x].to_i})
      else
        Time.parse(params[:date])
      end
    else
      Time.now.midnight + 2.years
    end
  end

  private

  def set_user
    @user = session[:user_id] ? Person.get(session[:user_id]) : nil
    #@user = Person.get(10083332)
    @affiliation = session[:user_affiliation]
    redirect_to test_url unless @user && @affiliation
  end

  def set_topic
    if @affiliation == "staff"
      if params[:person_id]
        @topic = Person.get(params[:person_id],params[:refresh]) or raise "No such user mis_id:#{params[:person_id]}"
      elsif params[:course_id]
        raise("Courses not implemented yet!")
      else
        @topic = @user
      end
    else
      @topic = @user
    end
  end

  def get_views
    @views = View.order("position").select{|v| v.affiliations.include? @affiliation}
  end

end
