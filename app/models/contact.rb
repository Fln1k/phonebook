class Contact < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :number, presence: true
  validates_uniqueness_of :number, :scope => [:user_id]
  validates_format_of :number, :with => /\A(80|\+375)?(\d{9})\z/,:message => "неверный формат номера"
end
