class Item < ApplicationRecord

  belongs_to :genre
  has_one_attached :image

  has_many :cart_items

  has_many :ordered_items
  has_many :orders, through: :ordered_items

  #def get_image(width,height)
  # unless image.attached?
  #     file_path = Rails.root.join('app/assets/default-image.jpeg')
  #     image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  #   end
  #   image
 # end

  def get_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/default-image.jpeg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    image.variant(resize_to_fit: [width, height]).processed
  end

  def add_tax_price
    (self.price * 1.10).floor
  end

end
