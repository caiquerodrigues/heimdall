require 'spec_helper'

RSpec.describe 'Controller' do
  let(:account) { create(:account, :full) }

  describe 'GET#status' do
    before do
      get '/status'
    end

    after do
      clear_cookies
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

  describe 'POST#auth' do
    context 'with valid parameters' do
      let(:account_params) do
        {
          account: {
            email: account.email,
            password: account.password,
          }
        }
      end

      before do
        post '/auth', account_params
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

      it 'sets HEIMDALL_AUTH cookie' do
        expect(last_response.headers['Set-Cookie'].include?('HEIMDALL_AUTH'))
      end
    end
  end

  describe 'POST#auth' do
    context 'with invalid parameters' do
      let(:account_params) do
        {
          account: {
            email: account.email,
            password: 'badpassword',
          }
        }
      end

      before do
        post '/auth', account_params
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

  describe 'PUT#update_account' do
    let!(:heimdall) { create(:account, :iamheimdall) }

    context 'for all parameters' do
      let(:account_params) do
        {
          account: {
            name: 'Heimdall Updated',
            surname: 'API Updated',
            email: 'iamheimdalltwo@local.com',
            password: 'bitfrost2',
            password_confirmation: 'bitfrost2',
            role: 'godmode'
          }
        }
      end

      before do
        set_cookie 'HEIMDALL_AUTH=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImlhbWhlaW1kYWxsQGxvY2FsLmNvbSIsImFwcCI6ImhlaW1kYWxsIn0.st8GvZSwVLdOXqE3qMREpqPuCwNAn8mwN6SBJFHvKXE'
        put '/account/update', account_params
      end

      after do
        clear_cookies
      end

      subject do
        Oj.load(last_response.body)[:message]
      end

      it 'returns successful creation' do
        expect(subject).to eq 'Account was updated!'
      end

      it 'returns status 200' do
        expect(last_response.status).to eq 200
      end
    end
  end
end
