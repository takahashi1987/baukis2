class Staff::Authenticator
  def initialize(staff_member)
    @staff_member = staff_member
  end

  def authenticate(row_password)
    @staff_member &&
    @staff_member.hashed_password &&
    @staff_member.start_date <= Date.today &&
    (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) &&
    BCrypt::Password.new(@staff_member.hashed_password) == row_password
  end
end
