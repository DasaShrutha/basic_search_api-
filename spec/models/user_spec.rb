# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:user_name) { "Dhiraj" }
  let(:email) { "Dhiraj@extended_web_tech.com" }
  let(:user_1) { described_class.new(first_name: user_name, email: email) }

	context "validations with first_name" do
    let(:user_2) { described_class.new(first_name: nil, email: email) }
    let(:user_3) { described_class.new(first_name: '', email: email) }

    it "is valid with a valid first_name" do
      expect(user_1.valid?).to eq(true)
    end

    it "is not valid when a first_name is not present" do
      expect(user_2.valid?).to eq(false)
    end

    it "is not valid when a first_name is blank" do
      expect(user_3.valid?).to eq(false)
    end
  end

  context "validations with email" do
    let(:user_2) { described_class.new(first_name: user_name, email: nil) }
    let(:user_3) { described_class.new(first_name: user_name, email: '') }

    it "is valid with a valid email" do
      expect(user_1.valid?).to eq(true)
    end

    it "is not valid when a email is not present" do
      expect(user_2.valid?).to eq(false)
    end

    it "is not valid when a email is blank" do
      expect(user_3.valid?).to eq(false)
    end
  end
end
