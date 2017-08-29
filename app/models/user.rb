# Represents a user account
# @author Chris Loftus
class User < ApplicationRecord
  validates_presence_of :firstname, :surname, :grad_year, :email
  validates_numericality_of :grad_year,
                            greater_than_or_equal_to: 1970,
                            less_than_or_equal_to: Time.now.year.to_i
  validates_format_of :email,
                      with: /\A([\w\.\-\+]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                      message: 'Bad email address format'

  validates_uniqueness_of :email
  
  has_one :image, dependent: :destroy
  
  has_one :user_detail, dependent: :destroy

  # This allows for the automatic creation of the UserDetail
  # object and link it to the User object. Nested :user_detail object
  # in the request is used.
  accepts_nested_attributes_for :user_detail
  
  def firstname=(value)
    write_attribute :firstname, (value ? value.humanize : nil)
  end

  def surname=(value)
    write_attribute :surname, (value ? value.humanize : nil)
  end

  self.per_page = 8

end
