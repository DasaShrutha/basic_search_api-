# frozen_string_literal: true

class User < ApplicationRecord

  class << self
    def search_for_word(word)
      string = word.downcase
      where("lower(first_name) LIKE ? OR lower(email) LIKE ? OR lower(last_name) LIKE ?", string, string, string)
    end
  end

  validates :first_name, presence: true, allow_blank: false
  validates :email, presence: true, allow_blank: false
end
