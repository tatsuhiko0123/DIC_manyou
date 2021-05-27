require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:admin_user)
  end
  describe 'ユーザ登録機能' do
    context '新規登録のテスト' do
      it '新規登録できること' do
        visit new_user_path
        fill_in :user_name, with: "goma"
        fill_in :user_email, with: "goma@gmail.com"
        fill_in :user_password, with: "111111"
        fill_in :user_password_confirmation, with: "111111"
        click_button '新規作成'
        expect(page).to have_content 'goma'
        expect(page).to have_content 'goma@gmail.com'
      end
    end
    context 'ログインせずに一覧画面に飛ぼうとした時のテスト' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'メールアドレス'
        expect(page).to have_content 'パスワード'
      end
    end    
  end
  describe 'セッション機能' do
    context 'ログイン,ログアウトのテスト' do
      it 'ログインができること' do
        visit new_session_path
        fill_in :session_email, with: "kuro@gmail.com"
        fill_in :session_password, with: "111111"
        click_on 'ログイン'
        expect(page).to have_content 'kuro@gmail.com'
      end
      it 'ログアウトできること' do
        visit new_session_path
        fill_in :session_email, with: "kuro@gmail.com"
        fill_in :session_password, with: "111111"
        click_on 'ログイン'
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end 
    context '詳細ページに飛べるテスト' do
      it '自分の詳細ページに飛べること' do
        visit new_session_path
        fill_in :session_email, with: "kuro@gmail.com"
        fill_in :session_password, with: "111111"
        click_on 'ログイン'
        expect(page).to have_content 'kuro@gmail.com'
      end
    end
  end
  describe '管理機能' do
    context '管理ユーザーが管理画面にアクセスした場合のテスト' do
      it '管理画面に遷移できること' do
        visit new_session_path
        fill_in :session_email, with: "kuro@gmail.com"
        fill_in :session_password, with: "111111"
        click_on 'ログイン'
        click_link '管理画面'
        expect(page).to have_content 'ユーザー一覧'
      end
    end
    context '一般ユーザーが管理画面にアクセスした場合のテスト' do
      it '管理画面に遷移できないこと' do
        visit new_session_path
        fill_in :session_email, with: "tora@gmail.com"
        fill_in :session_password, with: "111111"
        click_on 'ログイン'
        click_link '管理画面'
        expect(page).to have_content '管理画面へは、管理者以外はアクセスできません'
      end
    end
    context '管理ユーザーがユーザーの新規登録をした場合のテスト' do
      it '新規登録できること' do
        visit new_session_path
        fill_in :session_email, with: "kuro@gmail.com"
        fill_in :session_password, with: "111111"
        click_on 'ログイン'
        click_link '管理画面'
        click_link '新規ユーザー作成'
        fill_in :user_name, with: "goma"
        fill_in :user_email, with: "goma@gmail.com"
        fill_in :user_password, with: "111111"
        fill_in :user_password_confirmation, with: "111111"
        find("#user_admin").find("option[value='一般']").select_option
        click_on '登録する'
        expect(current_path).to have_content "/admin/users"
      end
    end
    context '管理ユーザーがユーザーの詳細画面にアクセスした場合のテスト' do
      it '詳細画面にアクセスできること' do
        visit new_session_path
        fill_in :session_email, with: "kuro@gmail.com"
        fill_in :session_password, with: "111111"
        click_on 'ログイン'
        click_link '管理画面'
        click_link '詳細を確認', match: :first
        expect(page).to have_content 'ユーザー詳細情報'
      end
    end
    context '管理ユーザーがユーザーの編集をした場合のテスト' do
      it 'ユーザーの編集画面から編集できること' do
        visit new_session_path
        fill_in :session_email, with: "kuro@gmail.com"
        fill_in :session_password, with: "111111"
        click_on 'ログイン'
        click_link '管理画面'
        page.accept_confirm do
          click_link 'ユーザー情報を編集', match: :first
        end
        fill_in :user_name, with: "goma"
        fill_in :user_email, with: "goma@gmail.com"
        fill_in :user_password, with: "111111"
        fill_in :user_password_confirmation, with: "111111"
        find("#user_admin").find("option[value='一般']").select_option
        click_on '更新する'
        expect(page).to have_content 'ユーザー情報を編集しました'
      end
    end
    context '管理ユーザーがユーザーの削除をした場合のテスト' do
      it 'ユーザーの削除できること' do
        visit new_session_path
        fill_in :session_email, with: "kuro@gmail.com"
        fill_in :session_password, with: "111111"
        click_on 'ログイン'
        click_link '管理画面'
        page.accept_confirm do
          click_link 'ユーザー情報を削除', match: :first
        end
        # binding.irb
        expect(page).to have_content 'ユーザー情報を削除しました'
      end
    end
  end
end