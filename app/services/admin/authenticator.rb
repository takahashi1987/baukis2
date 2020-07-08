class Admin::Authenticator
  def initialize(administrator)
    @administrator = administrator
  end

  def authenticate(row_password)
    @administrator &&
    @administrator.hashed_password &&
    BCrypt::Password.new(@administrator.hashed_password) == row_password
  end
end
