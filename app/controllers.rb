Heimdall::App.controllers  do

  get :status, map: '/status', provides: :json do
    'Bifrost bridge is up and running!'
  end

  get :authenticate, map: '/auth', provides: :json do
    if Account.authenticate(params[:email], params[:password])
      status 200
      body 'Authentication was successful!'
    else
      status 403
      body 'Authentication error!'
    end
  end

  post :create_account, map: '/auth/create', provides: :json do
    if Account.new(params[:account]).save
      status 200
      body 'Account was created!'
    else
      status 400
      body 'Problems when creating account.'
    end
  end

end
