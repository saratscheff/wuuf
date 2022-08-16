Rails.application.routes.draw do
  get 'solar_panel_distribution/preview'

  root 'home#view'
end
