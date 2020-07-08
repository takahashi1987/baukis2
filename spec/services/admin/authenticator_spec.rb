require "rails_helper"

describe Admin::Authenticator do
  describe "#authenticate" do
    example "正しいパスワードなら ture を返すこと" do
      administrator = build(:administrator)
      expect(Admin::Authenticator.new(administrator).authenticate("pw")).to be_truthy
    end

    example "誤ったパスワードなら false を返すこと" do
      administrator = build(:administrator)
      expect(Admin::Authenticator.new(administrator).authenticate("zz")).to be_falsey
    end

    example "パスワードが未設定なら false を返すこと" do
      administrator = build(:administrator, password: nil)
      expect(Admin::Authenticator.new(administrator).authenticate("pw")).to be_falsey
    end

    example "停止フラグが立っていても false を返すこと" do
      administrator = build(:administrator, suspended: true)
    end
  end
end
