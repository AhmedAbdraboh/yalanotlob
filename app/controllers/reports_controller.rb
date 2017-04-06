class ReportsController < ApplicationController
  layout false
  layout 'application', :except => "devise/sessions#new"
end
