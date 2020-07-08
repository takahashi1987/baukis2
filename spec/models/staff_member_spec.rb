require 'rails_helper'

RSpec.describe StaffMember, type: :model do
  describe "#password=" do
    it "hashed_password は長さ 60 の文字列になること" do
      member = StaffMember.new
      member.password = "baukis"
      expect(member.hashed_password.size).to eq(60)
    end

    it "hashed_password は nil になること" do
      member = StaffMember.new(hashed_password: "password")
      member.password = nil
      expect(member.hashed_password).to be_nil
    end
  end
end
