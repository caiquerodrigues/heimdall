require 'spec_helper'

RSpec.describe 'Controller' do
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
        allow(Account).to receive(:authenticate).and_return(true)

        get '/auth?email=admin@heimdall.local&password=goodpwd'
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
        allow(Account).to receive(:authenticate).and_return(false)

        get '/auth?email=admin@heimdall.local&password=badpwd'
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

  # describe 'POST#create_account' do
  #   context 'with valid parameters' do
  #     let(:account_as_json) do
  #       {
  #         account: {
  #           name: 'Admin',
  #           surname: 'Heimdall',
  #           email: 'admin@heimdall.local',
  #           password: 'good',
  #           password_confirmation: 'good',
  #           role: 'admin'
  #         }
  #       }
  #     end
  #
  #     before do
  #       allow(Account).to receive(:new).with(any_args).and_return( account)
  #       allow_any_instance_of(Account).to receive(:save).and_return(true)
  #       post '/account/create', account_as_json
  #     end
  #
  #     it 'returns successful creation' do
  #       expect(last_response.body).to eq 'Account was created!'
  #     end
  #
  #     it 'returns status 200' do
  #       expect(last_response.status).to eq 200
  #     end
  #   end
  # end
end
