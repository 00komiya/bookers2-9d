class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'

  has_many :book_tag_relations,dependent: :destroy
  has_many :tags, through: :book_tag_relations

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match" # 完全一致
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match" # 前方一致のため後ろに%
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match" # 後方一致のため前に%
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match" # 部分一致のため前後に%
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

end
