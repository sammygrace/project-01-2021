class RoomChannel < ApplicationCable::Channel
  def subscribed
    if params[:room] == params[:conversation_id]
      stream_from "room_#{params[:room]}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
