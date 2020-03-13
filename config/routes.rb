Rails.application.routes.draw do
  # devise routes

  devise_for :users, skip: %i[sessions registrations passwords confirmations]
  devise_scope :user do
    scope :auth, defaults: { format: :json } do
      resource :session,
               only: %i[create destroy],
               controller: 'devise/sessions'
      resource :registration,
               only: %i[create],
               controller: 'devise/registrations'
    end
  end
end
