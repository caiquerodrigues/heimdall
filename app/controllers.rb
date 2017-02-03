Heimdall::App.controllers  do

  before :create_account do
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

  get :authenticate, map: '/auth', provides: :json do
    account_authenticated = Account.authenticate(params[:email], params[:password])
    halt 401, render_message('Authentication error!') unless account_authenticated
    render_message 'Authentication was successful!'
  end

  post :create_account, map: '/account/create', provides: :json do
    account = Account.new(@account_params)

    halt 400, render_message('Problems when creating account.') unless account.save
    render_message 'Account was created!'
  end
end
