# require_relative 'helpers/session'

feature 'User sign in' do
  let!(:user) do
    User.create(email: 'user@example.com',
                name: 'user',
                username: 'user1',
                password: 'password',
                password_confirmation: 'password')
  end

  scenario 'with correct credentials' do
    sign_in(email: user.email,   password: user.password)
    expect(page).to have_content "Welcome, User"
  end
  # 
  # def sign_in(email:, password:)
  #   visit '/sessions/new'
  #   fill_in :email, with: email
  #   fill_in :password, with: password
  #   click_button 'Sign in'
  # end

end
