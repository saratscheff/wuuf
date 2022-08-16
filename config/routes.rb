Rails.application.routes.draw do
  get 'solar_panel_distribution/preview'

  get '/solar_panel_distribution/dimmensions_form' => 'solar_panel_distribution#dimmensions_form', as: 'dimmensions_form'
  post '/solar_panel_distribution/dimmensions_form_submit' => 'solar_panel_distribution#dimmensions_form_submit', as: 'dimmensions_form_submit'

  root 'home#view'
end
