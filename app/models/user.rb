class User < ActiveRecord::Base
  rolify
  uuid_it
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :school_attributes, :role_ids

  belongs_to :school
  accepts_nested_attributes_for :school, reject_if: :all_blank

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: { if: :new_record? }, confirmation: { if: :new_record?}

  scope :by_last_name, ->() { order("users.last_name DESC") }

  after_create :add_default_roles

  def to_s
    full_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def first_initial_last_name
    "#{first_name.first}. #{last_name}"
  end

  def role_names
    self.roles.collect(&:name).map(&:titleize).to_sentence
  end

  private
  def add_default_roles
    self.add_role :manager
  end
end
