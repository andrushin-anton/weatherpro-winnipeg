class AttachmentsController < ApplicationController
  
  def new
    if params[:id] && params[:file_url]
      attachment = Attachment.new
      attachment.appointment_id = params[:id]
      attachment.file_url = params[:file_url]
      attachment.file_name = params[:filename]
      attachment.save
    end
  end
  
end
