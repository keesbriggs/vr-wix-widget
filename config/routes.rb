RssFeedRails::Application.routes.draw do

  root :to => redirect('/help')

  match "/widget" => "app#widget"

  match '/settings' => "app#settings"

  match '/app/settingsupdate' => "app#settingsupdate"

  match "/authenticate" => "app#authenticate"

  match "/savetoken" => "app#savetoken" # was oauth#savetoken

end
