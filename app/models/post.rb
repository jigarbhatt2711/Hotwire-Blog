class Post < ApplicationRecord
  validates :title, :content, :author, presence: true

    # ✅ One line does everything!
  broadcasts_to ->(post) { "posts" },
    inserts_by: :prepend,
    target: "posts_list"

  # This automatically:
  # after_create  → prepend to posts_list
  # after_update  → replace post card
  # after_destroy → remove post card
  # For ALL connected users! ✅
end
