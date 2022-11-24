class OrderedItem < ApplicationRecord

  enum making_status_method: { wait: 0, waiting: 1, making: 2, completed: 3 }

end
