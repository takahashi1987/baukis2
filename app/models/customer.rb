class Customer < ApplicationRecord
  has_one :home_address, dependent: :destroy
  has_one :work_address, dependent: :destroy

  validates :gender, inclusion: { in: %w(male female), allow_black: true }
  validates :birthday, date: { after: Date.new(1990, 1, 1), before: ->(obj) { Date.today }, allow_blank: true }

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end
end