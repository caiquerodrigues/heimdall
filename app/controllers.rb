Heimdall::App.controllers  do

  before except: :status do
    @account_params = payload('account').extract!('name',
                                                  'surname',
                                                  'email',
                                                  'password',
                                                  'password_confirmation',
                                                  'role')
  end

  before :update_account do
    encoded_token = @request.cookies['HEIMDALL_AUTH']
    @token = decode(encoded_token)
  end

  get :status, map: '/status', provides: :json do
    render_message 'Bifrost bridge is up and running!'
  end

  post :authenticate, map: '/auth', provides: :json do
    account_authenticated = Account.authenticate(@account_params['email'], @account_params['password'])
    halt 401, render_message('Authentication error!') unless account_authenticated

    @response.set_cookie('HEIMDALL_AUTH', encode(account_authenticated.as_payload))

    render_message 'Authentication was successful!'
  end

  post :create_account, map: '/account/create', provides: :json do
    account = Account.new(@account_params)

    halt 400, render_message('Problems creating account.') unless account.save
    render_message 'Account was created!'
  end

  put :update_account, map: '/account/update', provides: :json do
    @account_params.delete_if do |param, value|
      param =~ /password/
    end

    account = Account.find_by(email: @token['email']) if @token
    halt 400, render_message('Problems updating account.') unless account.update(@account_params)
    render_message 'Account was updated!'
  end
end
