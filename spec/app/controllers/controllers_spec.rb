require 'spec_helper'

RSpec.describe 'Controller' do
  let(:account) { create(:account, :full) }

  describe 'GET#status' do
    before do
      get '/status'
    end

    subject do
      Oj.load(last_response.body)[:message]
    end

    it 'returns good message' do
      expect(subject).to eq 'Bifrost bridge is up and running!'
    end

    it 'returns status 200' do
      expect(last_response.status).to eq 200
    end
  end

  describe 'GET#auth' do
    context 'with valid parameters' do
      before do
        get '/auth', email: account.email, password: account.password
      end

      subject do
        Oj.load(last_response.body)[:message]
      end

      it 'returns successful authentication' do
        expect(subject).to eq 'Authentication was successful!'
      end

      it 'returns status 200' do
        expect(last_response.status).to eq 200
      end
    end
  end

  describe 'GET#auth' do
    context 'with invalid parameters' do
      before do
        get '/auth', email: account.email, password: 'badpassword'
      end

      subject do
        Oj.load(last_response.body)[:message]
      end

      it 'returns successful authentication' do
        expect(subject).to eq 'Authentication error!'
      end

      it 'returns status 401' do
        expect(last_response.status).to eq 401
      end
    end
  end

  describe 'POST#create_account' do
    context 'with valid parameters' do
      let(:account_params) do
        {
          account: {
            name: 'Heimdall',
            surname: 'API',
            email: 'iamheimdall@local.com',
            password: 'bitfrost',
            password_confirmation: 'bitfrost',
            role: 'admin'
          }
        }
      end

      before do
        post '/account/create', account_params
      end

      subject do
        Oj.load(last_response.body)[:message]
      end

      it 'returns successful creation' do
        expect(subject).to eq 'Account was created!'
      end

      it 'returns status 200' do
        expect(last_response.status).to eq 200
      end
    end
  end
end
