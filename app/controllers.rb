Heimdall::App.controllers  do

  get :status, map: '/status', provides: :json do
    halt 200, 'Bifrost bridge is up and running!'
  end

  get :authenticate, map: '/auth', provides: :json do
    halt 200, 'Authentication was successful!' if Account.authenticate(params[:email], params[:password])
    halt 401, 'Authentication error!'
  end

  # post :create_account, map: '/account/create', provides: :json do
  #   halt 200, 'Account was created!' if Account.new(params[:account]).save
  #   halt 400, 'Problems when creating account.'
  # end

end
