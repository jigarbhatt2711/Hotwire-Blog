class PostsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "posts_channel"
    puts "User subscribed to posts channel! ✅"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    puts "User unsubscribed from posts channel"
  end
end
