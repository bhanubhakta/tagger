
require 'rails_helper'

describe Tagger::Api::V1::BreedsController do

  routes { Tagger::Engine.routes }

  describe '#index' do
    subject { get :index }
    before {
      Tagger::Entity.create(name: 'Test breed')
      subject
    }

    it 'returns http success' do
      expect(response.status).to be 200
    end

    it 'returns the breeds' do
      expect(JSON.parse(response.body).first['name']).to eq('Test breed')
    end
  end

  describe '#create' do
    subject { post :create, { params: { name: 'Testing' } } }
    before {
      subject
    }

    it 'returns http success' do
      expect(response.status).to be 201
    end

    it 'creates a breed' do
      expect(Tagger::Entity.count).to eq(1)
    end

    it 'returns the breeds' do
      expect(Tagger::Entity.last.name).to eq('Testing')
    end
  end

  describe '#show' do
    subject { get :show, { params: { id: id } } }
    before {
      Tagger::Entity.create({ name: 'Testing' })
      Tagger.tagged_resource = 'entity'
      subject
    }

    context 'valid id' do

      let(:id) { Tagger::Entity.last.id }

      it 'returns http success' do
        expect(response.status).to be 200
      end

      it 'gives the record' do
        expect(JSON.parse(response.body)['entity']['name']).to eq('Testing')
      end
    end

    context 'invalid id' do
      let(:id) { 123 }
      it 'returns http faliure' do
        expect(response.status).to be(422)
      end
    end
  end

  describe '#update' do
    subject { patch :update, { params: { id: Tagger::Entity.last.id, name: 'Updated Testing', tags: ['My tag'].to_json } } }
    before {
      Tagger::Entity.create({ name: 'Testing' })
      subject
    }

    it 'returns http success' do
      expect(response.status).to be 201
    end

    it 'updates the record' do
      expect(Tagger::Entity.last.name).to eq('Updated Testing')
    end
  end
end
