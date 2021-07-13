class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :destroy]

  def index
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message.conversation, notice: 'Message sent!' }
        format.json { render :show, status: :created, location: @message }

        ActionCable.server.broadcast "room_channel", 
          content: @message.content, 
          conversation_id: @message.conversation_id, 
          user_id: @message.user_id,
          created_at: @message.created_at
      else
        format.html { redirect_to @message.conversation, notice: "Message could not be sent :(" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.require(:message).permit(:content, :conversation_id, :user_id)
    end
end
