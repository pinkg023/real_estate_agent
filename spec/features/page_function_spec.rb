require 'rails_helper'

RSpec.feature "page_function", js: true do
  let(:manager) { create :admin_user }
  let(:user) { create :user }
  let!(:post) { create :post }

    scenario "normal user login and generate invitation" do
      #一般使用者登入
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

      #至會員中心
      click_on '會員中心'
      expect(page).to have_selector(:link_or_button, '顯示推薦連結')
      expect(page).to have_selector(:link_or_button, '好友邀請列表')
      expect(page).to have_selector(:link_or_button, '修改會員資料')
      expect(page).to have_selector(:link_or_button, '修改密碼')

      #產生推薦連結
      click_on '顯示推薦連結'

      #推薦的好友註冊帳號
      visit "invitations/#{User.first.invite_token}"
      within('.new_reg') do
        fill_in 'reg_email', with: 'ming_test@example.com'
        fill_in 'reg_name', with: '王小明'
        fill_in 'reg_cel', with: '00000000'
        fill_in 'reg_tel', with: '09000000'
        fill_in 'reg_password', with: 'iamyourfriend'
        fill_in 'reg_password_confirmation', with: 'iamyourfriend'
        fill_in 'reg_description', with: '土地分割'
        click_on '註冊'
      end

      expect(page).to have_text('ming_test@example.com')

      #查看使用者的好友邀請是否增加好友的資訊
      click_on '登出'
      click_on '登入'
      within('.new_user') do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_on '登入'
      end

      click_on '會員中心'
      click_on '好友邀請列表'
      expect(page).to have_text('ming_test@example.com')
    end

    scenario "admin user login and create post" do
      #管理者登入
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

      #至後台管理頁面
      click_on '管理後台'
      expect(page).to have_selector(:link_or_button, '公告管理')
      expect(page).to have_selector(:link_or_button, '會員管理')
      expect(page).to have_selector(:link_or_button, '新增公告')
      expect(page).to have_text('this is the first post')

      #新增公告
      within('.new_post') do
        fill_in 'post_title', with: 'test post 01'
        fill_in 'post_description', with: 'test~~~~~~~'
      end
      click_on '新增公告'
      expect(page).to have_text('test~~~~~~~')

      #編輯公告
      find(:css, 'i.fa.fa-pencil-square-o', match: :first).click
      within('.edit_post') do
        fill_in 'post_title', with: 'huei post'
        fill_in 'post_description', with: 'this is Huei"s first post'
      end
      click_on '修改公告'
      expect(page).to have_text('this is Huei"s first post')

      #刪除公告
      find(:css, 'i.fa.fa-trash', match: :first).click
      expect(page).not_to have_text('this is Huei"s first post')
    end

end
