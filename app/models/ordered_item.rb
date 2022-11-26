class OrderedItem < ApplicationRecord

  enum making_status: { wait: 0, waiting: 1, making: 2, completed: 3 }

  belongs_to :item
  belongs_to :order

  def get_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/default-image.jpeg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    image.variant(resize_to_fit: [width, height]).processed
  end

end
