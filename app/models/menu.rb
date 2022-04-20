class Menu < ApplicationRecord
  has_many :menu_categories
  has_many :categories, through: :menu_categories
  validates :name, presence: true, uniqueness: true, length: { maximum: 150,
    too_long: "%{count} characters is the maximum allowed" }
  validates :price, presence: true, comparison: { greater_than_or_equal_to: 0.01 }

  # def save_menu_and_categories(menu_category_params)
  #   self.save
  #   menu_category_params.each do |menu_category|
  #     MenuCategory.create(menu_id: id, category_id: menu_category[:id])
  #   end
  # end

  def category_exits?(menu_category_params)
    menu_category_params.each do |menu_category|
      if Category.find_by(id: menu_category[:id]).nil?
        self.errors.add(:category, "with id : #{menu_category[:id]} is not exits")
      end
    end
    return self.errors[:category].empty?
  end

end
