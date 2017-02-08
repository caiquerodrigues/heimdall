Heimdall::App.controllers  do

  before :create_account, :authenticate do
    @account_params = payload('account').extract!('name',
                                                  'surname',
                                                  'email',
                                                  'password',
                                                  'password_confirmation',
                                                  'role')
  end

  get :status, map: '/status', provides: :json do
    render_message 'Bifrost bridge is up and running!'
  end

  post :authenticate, map: '/auth', provides: :json do
    # require 'pry'; binding.pry
    account_authenticated = Account.authenticate(@account_params['email'], @account_params['password'])
    halt 401, render_message('Authentication error!') unless account_authenticated

    @response.set_cookie('HEIMDALL_AUTH', encode(account_authenticated.as_payload))

    render_message 'Authentication was successful!'
  end

  post :create_account, map: '/account/create', provides: :json do
    account = Account.new(@account_params)

    halt 400, render_message('Problems when creating account.') unless account.save
    render_message 'Account was created!'
  end
end
