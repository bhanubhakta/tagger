require 'rails_helper'

describe Tagger::Api::V1::TagsController do

  routes { Tagger::Engine.routes }

  describe '#index' do
    subject { get :index }
    before {
      Tagger::Tag.create(name: 'Test tag')
      subject
    }

    it 'returns http success' do
      expect(response.status).to be 200
    end

    it 'returns the breeds' do
      expect(JSON.parse(response.body).first['name']).to eq('Test tag')
    end
  end

  describe '#show' do
    subject { get :show, { params: { id: id } } }
    before {
      Tagger::Tag.create({ name: 'Testing' })
      subject
    }

    context 'valid id' do

      let(:id) { Tagger::Tag.last.id }

      it 'returns http success' do
        expect(response.status).to be 200
      end

      it 'gives the record' do
        expect(JSON.parse(response.body)['name']).to eq('Testing')
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
    subject { patch :update, { params: { id: Tagger::Tag.last.id, name: 'Updated Testing' } } }
    before {
      Tagger::Tag.create({ name: 'Testing' })
      subject
    }

    it 'returns http success' do
      expect(response.status).to be 201
    end

    it 'updates the record' do
      expect(Tagger::Tag.last.name).to eq('Updated Testing')
    end
  end
end
