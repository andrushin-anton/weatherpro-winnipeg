class LogsController < ApplicationController
  def index
    @logs = Logs.search(params[:search], params[:page])
  end
end
