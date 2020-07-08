require 'rails_helper'

RSpec.describe Administrator, type: :model do
  describe "password=" do
    it "hashed_password は長さ 60 の文字列になること" do
      administrator = Administrator.new
      administrator.password = "password"
      expect(administrator.hashed_password.size).to eq(60)
    end
    it "hashed_password は nil になること" do
      administrator = Administrator.new
      administrator.password = nil
      expect(administrator.hashed_password).to be_nil
    end
  end
end
