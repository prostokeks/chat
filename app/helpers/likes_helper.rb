module LikesHelper
  def likes_count(message)
   "#{message.likes_count}" if message.likes_count.positive?
  end

  def heart (message, user)
    if message.likes.find_by(user: user).present?
      "🧡"
    else
      "🤍"
    end
  end
end
