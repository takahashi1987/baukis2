require "rails_helper"

describe Staff::Authenticator do
  describe "#authenticate" do
    example "正しいパスワードなら ture を返すこと" do
      member = build(:staff_member)
      expect(Staff::Authenticator.new(member).authenticate("pw")).to be_truthy
    end

    example "誤ったパスワードなら false を返すこと" do
      member = build(:staff_member)
      expect(Staff::Authenticator.new(member).authenticate("aa")).to be_falsey
    end

    example "パスワードが設定されていなければ false を返すこと" do
      member = build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(member).authenticate(nil)).to be_falsey
    end

    example "停止フラグが立っていれば false を返すこと" do
      member = build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(member).authenticate("pw")).to be_falsey
    end

    example "開始前なら false を返すこと" do
      member = build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(member).authenticate("pw")).to be_falsey
    end

    example "終了後なら false を返すこと" do
      member = build(:staff_member, end_date: Date.yesterday)
      expect(Staff::Authenticator.new(member).authenticate("pw")).to be_falsey
    end
  end
end
