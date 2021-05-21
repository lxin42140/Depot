class ProductPart < ApplicationRecord
  belongs_to :product

  validates :name, :date_expired, :description, presence: true

  def get_hour_min_difference
    from_time =  Date.today.to_time
    to_time = date_expired.to_time
    distance_in_hours   = (((to_time - from_time).abs) / 3600).floor
    distance_in_minutes = ((((to_time - from_time).abs) % 3600) / 60).round
  
    difference_in_words = ''
  
    difference_in_words << "#{distance_in_hours} #{distance_in_hours > 1 ? 'hours' : 'hour' } and " if distance_in_hours > 0
    difference_in_words << "#{distance_in_minutes} #{distance_in_minutes == 1 ? 'minute' : 'minutes' }"
  end 
end
