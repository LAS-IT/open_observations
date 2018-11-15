class ObservationFocus < ActiveRecord::Base
  belongs_to :observation
  belongs_to :focus
  # attr_accessible :title, :body
end
