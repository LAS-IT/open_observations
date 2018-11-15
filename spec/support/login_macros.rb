module LoginMacros
  def sign_in_as(user)
    visit root_path
    within("#new_user") do
      fill_in 'Your Email', with: user.email
      fill_in 'Password', with: 'a1b2c3d4e5'
      click_button 'Sign In'
    end
  end
end

RSpec.configure do |config|
  config.include LoginMacros, type: :feature
end