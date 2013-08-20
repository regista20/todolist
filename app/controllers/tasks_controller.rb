class TasksController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  respond_to :html, :js

  def create
    @task = current_user.tasks.build(params[:task])
    @feed_items = current_user.feed.paginate(page: params[:page])
    if @task.save
      flash[:success] = "Task created!"
      respond_with root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @task.destroy
    @feed_items = current_user.feed.paginate(page: params[:page])
    flash[:success] = "Task created!"
    respond_with root_url
  end

  private

    def correct_user
      @task = current_user.tasks.find_by_id(params[:id])
      redirect_to root_url if @task.nil?
    end
end