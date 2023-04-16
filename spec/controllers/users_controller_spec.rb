# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController do
  describe '/users' do
    it 'returns all the users present' do
      get :index
      json_response = JSON.parse(response.body)
      expect(json_response).to eq(User.all.as_json)
    end
  end

  describe 'GET /users/new' do
    it 'returns the new user object' do
      get :new
      json_response = JSON.parse(response.body)
      expect(json_response).to eq({ 'id' => nil, 'first_name' => nil, 'last_name' => nil, 'email' => nil, 'phone_number' => nil,
                                    'created_at' => nil, 'updated_at' => nil })
    end
  end

  describe 'POST /users' do
    let(:first_name) { 'Ashrut' }
    let(:last_name) { 'Panchal' }
    let(:email) { 'ash@test.com' }

    it 'create and returns the user' do
      get :create, params: { user: { first_name: first_name, last_name: last_name, email: email } }
      json_response = JSON.parse(response.body)
      expect(json_response['first_name']).to eq(first_name)
      expect(json_response['last_name']).to eq(last_name)
      expect(json_response['email']).to eq(email)
    end
  end

  describe 'GET /users/search' do
  	before do
  		@user_1 = User.create!(first_name: "Ashrut", last_name: "Panchal", email: "ash@test.com")
  		@user_2 = User.create!(first_name: "Dhiraj", email: "dhiraj@test.com")
  		@user_3 = User.create!(first_name: "Myself", last_name: "Dhiraj", email: "dhiraj@test.com")
  	end

  	context "when the word matches with the records" do
		  let(:word) { "Dhiraj" }
			it "returns the searched result with matched records" do
		  	get :search, params: { word: word }
		  	json_response = JSON.parse(response.body)
		  	expect(json_response.pluck("id")).to include(@user_2.id)
		  	expect(json_response.pluck("id")).to include(@user_3.id)
			end
  	end

  	context "when the word does not matche with the records" do
		  let(:word) { "Random" }
			it "returns the blank searched result" do
		  	get :search, params: { word: word }
		  	json_response = JSON.parse(response.body)
		  	expect(json_response).to eq([])
			end
  	end
  end
end
