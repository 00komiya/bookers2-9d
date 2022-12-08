class Tag < ApplicationRecord

  has_many :book_tag_relations, dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿を持つ　それは、book_tag_relationsを通じて参照できる
  has_many :books, through: :book_tag_relations


  validates :name, uniqueness: true, presence: true

  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:tagname) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete　Tag.find_by(tagname: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_book_tag = Tag.find_or_create_by(tagname: new)
      self.tags << new_book_tag
    end
  end

end
