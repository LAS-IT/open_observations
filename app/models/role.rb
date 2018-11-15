class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  attr_accessible :name
  validates :name, uniqueness: true
  
  scopify

  scope :by_name, ->() { order("roles.name ASC") }
  scope :for_manager, ->() { where("roles.name NOT LIKE 'admin'")}
end
