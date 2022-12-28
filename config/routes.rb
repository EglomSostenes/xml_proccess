Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "notes#index"

  get "notes", to: "notes#index", as: :notes
  get "notes/:id/report", to: "notes#report", as: :report
  get "proccess_note", to: "notes#proccess_note", as: :proccess_note
  post "import_notes", to: "notes#import_notes", as: :import_notes
end
