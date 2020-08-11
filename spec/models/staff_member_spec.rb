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

  describe "値の正規化" do
    example "email 前後の空白を除去" do
      member = create(:staff_member, email: " test@example.com ")
      expect(member.email).to eq("test@example.com")
    end

    example "email に含まれる全角英数字記号を半角に変換する" do
      member = create(:staff_member, email: " ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ ")
      expect(member.email).to eq("test@example.com")
    end

    example "email 前後の全角スペースを除去" do
      member = create(:staff_member, email: "\u{3000}test@example.com\u{3000}")
      expect(member.email).to eq("test@example.com")
    end

    example "family_name_kana に含まれるひらがなをカタカナに変換" do
      member = create(:staff_member, family_name_kana: "てすと")
      expect(member.family_name_kana).to eq("テスト")
    end

    example "family_name_kana に含まれる半角カタカナを全角カタカナに変換" do
      member = create(:staff_member, family_name_kana: "ﾃｽﾄ")
      expect(member.family_name_kana).to eq("テスト")
    end
  end

  describe "バリデーション" do
    example "@が2個含むメールアドレスは無効" do
      member = build(:staff_member, email: "test@@example.com")
      expect(member).to_not be_valid
    end

    example "漢字を含む family_name_kana は無効" do
      member = build(:staff_member, family_name_kana: "高橋")
      expect(member).to_not be_valid
    end

    example "メールアドレスが重複した場合無効" do
      create(:staff_member, email: "test@example.com")
      member = build(:staff_member, email: "test@example.com")
      expect(member).to_not be_valid
    end

    example "アルファベットの family_name は有効" do
      member = build(:staff_member, family_name: "Smisu")
      expect(member).to be_valid
    end

    example "記号を含む family_name は無効" do
      member = build(:staff_member, family_name: "Smisu!!")
      expect(member).to_not be_valid
    end
  end
end
