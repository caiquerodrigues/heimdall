Heimdall::App.controllers  do

  get :status, map: '/status', provides: :json do
    Oj.dump(message: 'Bifrost bridge is up and running!')
  end

  get :authenticate, map: '/auth', provides: :json do
    is_user_authenticated = Account.authenticate(params[:email], params[:password])
    halt 401, Oj.dump(message: 'Authentication error!') unless is_user_authenticated
    Oj.dump(message: 'Authentication was successful!')
  end

  # post :create_account, map: '/account/create', provides: :json do
  #   halt 200, 'Account was created!' if Account.new(params[:account]).save
  #   halt 400, 'Problems when creating account.'
  # end

end
