require 'rails_helper'

RSpec.feature "page_function", js: true do
  let(:manager) { create :admin_user }
  let(:user) { create :user }
  let!(:post) { create :post }

    scenario "normal user login and generate invitation" do
      visit "pages/index"
      expect(page).to have_selector(:link_or_button, '註冊')
      expect(page).to have_selector(:link_or_button, '登入')

      click_on '登入'
      expect(page).to have_text('Email')
      expect(page).to have_text('密碼')

      within('.new_user') do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_on '登入'
      end

      expect(page).to have_text('test@example.com 您好')
      expect(page).to have_selector(:link_or_button, '會員中心')

      click_on '會員中心'
      expect(page).to have_selector(:link_or_button, '顯示推薦連結')
      expect(page).to have_selector(:link_or_button, '好友邀請列表')
      expect(page).to have_selector(:link_or_button, '修改會員資料')
      expect(page).to have_selector(:link_or_button, '修改密碼')

      click_on '顯示推薦連結'
      # expect(page).to have_selector(:link_or_button, '關閉')
      # visit "invitations/#{user.invite_token}"
    end

    scenario "admin user login and create post" do
      visit "pages/index"
      expect(page).to have_selector(:link_or_button, '註冊')
      expect(page).to have_selector(:link_or_button, '登入')

      click_on '登入'
      expect(page).to have_text('Email')
      expect(page).to have_text('密碼')

      within('.new_user') do
        fill_in 'user_email', with: manager.email
        fill_in 'user_password', with: manager.password
        click_on '登入'
      end      

      expect(page).to have_text('admin@example.com 您好')
      expect(page).to have_selector(:link_or_button, '會員中心')
      expect(page).to have_selector(:link_or_button, '管理後台')

      click_on '管理後台'
      expect(page).to have_selector(:link_or_button, '公告管理')
      expect(page).to have_selector(:link_or_button, '會員管理')  
      # expect(page).to have_selector(:link_or_button, '發布公告') 
      expect(page).to have_text('this is the first post')

      # within('.new_post') do
      #   fill_in 'post_title', with: 'test post 01'
      #   fill_in 'post_description', with: 'test~~~~~~~' 
      # end
      # click_on '發布公告'
      # expect(page).to have_text('test~~~~~~~')

      find(:css, 'i.fa.fa-pencil-square-o', match: :first).click
      within('.edit_post') do
        fill_in 'post_title', with: 'huei post'
        fill_in 'post_description', with: 'this is Huei"s first post' 
      end
      click_on '修改公告'
      expect(page).to have_text('this is Huei"s first post')

      find(:css, 'i.fa.fa-trash', match: :first).click
      expect(page).not_to have_text('this is Huei"s first post')



    end

end
