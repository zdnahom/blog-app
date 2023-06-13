require 'rails_helper'
RSpec.describe "Users", type: :request do
    let(:valid_attributes) { {name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.'} }
    
    describe "GET /index" do
        it "returns a successful response" do
            get users_url 
            expect(response).to be_successful
        end

        it "renders a correct template" do
            get users_url 
            expect(response).to render_template('index')
        end

        it "includes a placeholder" do
            get users_url 
            expect(response.body).to include('Number of posts: 100')
        end

    end

    describe "GET /show" do
        it "renders a successful response" do
            user = User.create! valid_attributes 
            get user_url(user)
            expect(response).to be_successful
        end
        
        it "renders a correct template" do
            user = User.create! valid_attributes 
            get user_url(user)
            expect(response).to render_template('detail')
        end

        it "includes a placeholder" do
            user = User.create! valid_attributes 
            get user_url(user)
            expect(response.body).to include('Bio')
        end

    end
end
