require 'rails_helper'
begin
  require "flats_controller"
rescue LoadError
end

if defined?(FlatsController)
  RSpec.describe FlatsController, :type => :controller do

    let(:valid_attributes) do
      {
        name: 'Light & Spacious Garden Flat London',
        address: '10 Clifton Gardens London W9 1DT',
        description: 'A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory',
        price_per_night: 75,
        number_of_guests: 3,
      }
    end

    let(:invalid_attributes) do
      { name: "" }
    end

    let(:valid_session) { {} }

    describe "GET index" do
      it "routes to #index" do
        expect(:get => "/flats").to route_to("flats#index")
      end
      it "assigns all flats as @flats" do
        flat = Flat.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(assigns(:flats)).to eq([flat])
      end
    end

    describe "GET show" do
      it "routes to #show" do
        expect(:get => "/flats/1").to route_to("flats#show", :id => "1")
      end
      it "assigns the requested flat as @flat" do
        flat = Flat.create! valid_attributes
        get :show, params: {:id => flat.to_param}, session: valid_session
        expect(assigns(:flat)).to eq(flat)
      end
    end

    describe "GET new" do
      it "routes to #new" do
        expect(:get => "/flats/new").to route_to("flats#new")
      end
      it "assigns a new flat as @flat" do
        get :new, params: {}, session: valid_session
        expect(assigns(:flat)).to be_a_new(Flat)
      end
    end

    describe "POST create" do
      it "routes to #create" do
        expect(:post => "/flats").to route_to("flats#create")
      end
      describe "with valid params" do
        it "creates a new Flat" do
          expect {
            post :create, params: {:flat => valid_attributes}, session: valid_session
          }.to change(Flat, :count).by(1)
        end

        it "assigns a newly created flat as @flat" do
          post :create, params: {:flat => valid_attributes}, session: valid_session
          expect(assigns(:flat)).to be_a(Flat)
          expect(assigns(:flat)).to be_persisted
        end

        it "redirects to the created flat" do
          post :create, params: {:flat => valid_attributes}, session: valid_session
          expect(response).to redirect_to(Flat.last).or redirect_to(flats_path)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved flat as @flat" do
          post :create, params: {:flat => invalid_attributes}, session: valid_session
          expect(assigns(:flat)).to be_a_new(Flat)
        end

        it "re-renders the 'new' template" do
          post :create, params: {:flat => invalid_attributes}, session: valid_session
          expect(response).to render_template("new")
        end
      end
    end
  end
else
  describe "FlatsController" do
    it "should exist" do
      expect(defined?(FlatsController)).to eq(true)
    end
  end
end
