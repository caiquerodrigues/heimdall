Heimdall::App.controllers  do

  before :update_account, :update_password do
    encoded_token = @request.cookies['HEIMDALL_AUTH']
    @token = decode(encoded_token)
  end

  before except: [:status, :update_password] do
    @account_params = payload('account').extract!('name',
                                                  'surname',
                                                  'email',
                                                  'password',
                                                  'password_confirmation',
                                                  'role')
  end

  before :update_password do
    @account_params = payload('account').extract!('old_password',
                                                  'password',
                                                  'password_confirmation')
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
    account = Account.find_by(email: @token['email']) if @token

    halt 401, render_message('Not authorized') unless account

    @account_params.delete_if do |param, value|
      param =~ /password/
    end

    halt 400, render_message('Problems updating account.') unless account.update(@account_params)
    render_message 'Account was updated!'
  end

  put :update_password, map: '/account/update_password', provides: :json do
    account_authenticated = Account.authenticate(@token['email'], @account_params['old_password']) if @token

    halt 401, render_message('Not authorized') unless account_authenticated

    @account_params.delete('old_password')
    halt 400, render_message('Problems updating account.') unless account_authenticated.update(@account_params)
    render_message 'Account was updated!'
  end
end
