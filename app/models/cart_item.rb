class CartItem < ApplicationRecord

  belongs_to :item
  belongs_to :customer


  def get_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/default-image.jpeg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    image.variant(resize_to_fit: [width, height]).processed
  end


  def subtotal
    item.add_tax_price * amount
  end
end
