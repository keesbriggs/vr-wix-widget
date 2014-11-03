RssFeedRails::Application.routes.draw do

  root :to => redirect('/help')

  match "/widget" => "app#widget"

  match "/preview_widget" => "app#preview_widget"

  match "/preview_settings" => "app#preview_settings"

  match "/preview_update_settings" => "app#preview_update_settings"

  match "/settings" => "app#settings"

  match "/app/settingsupdate" => "app#settingsupdate"

  match "/authenticate" => "app#authenticate"

  match "/savetoken" => "app#savetoken" 

end
