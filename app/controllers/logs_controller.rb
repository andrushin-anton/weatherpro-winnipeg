class LogsController < ApplicationController
  def index
    authorize! :logs, Logs

    @logs = Logs.search(params[:search], params[:page])
  end
end
