class Tag < ApplicationRecord

  has_many :book_tag_relations, dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿を持つ　それは、book_tag_relationsを通じて参照できる
  has_many :books, through: :book_tag_relations


  validates :name, uniqueness: true, presence: true

end
