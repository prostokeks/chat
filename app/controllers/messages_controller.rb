class MessagesController < ApplicationController

  def create
    @new_message = current_user&.messages&.build(strong_params)

    if @new_message&.save
      room = @new_message.room
      @new_message.broadcast_append_to room, target: "room_#{room.id}_messages", locals: {user: current_user}
    end
  end

  def like
    @message = Message.find(params[:id])
    like = @message.likes.find_by(user: current_user)

    if like.present?
      like.destroy
    else
      @message.likes.create(user: current_user)
    end
      room = @message.room
      @message.broadcast_replace_to [current_user, room], target: "message_#{@message.id}_likes", locals: {user: current_user, message: @message}, partial: "messages/heart"
      @message.broadcast_replace_to room, target: "message_#{@message.id}_likes_count", locals: {user: current_user, message: @message}, partial: "messages/likes_count"
  end

  private

  def strong_params
    params.require(:message).permit(:room_id, :body)
  end
end
