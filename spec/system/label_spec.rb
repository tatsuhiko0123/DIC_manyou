require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  before do
    FactoryBot.create(:user)
    visit new_session_path
    fill_in :session_email, with: "tora@gmail.com"
    fill_in :session_password, with: "111111"
    click_on 'ログイン'
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクにラベルを設定できること' do
        FactoryBot.create(:label)
        visit new_task_path
        fill_in :task_title, with: "title"
        fill_in :task_content, with: "content"
        fill_in :task_expired_at, with: "002021-05-22"
        find("#task_status").find("option[value='着手']").select_option
        check 'label_name1'
        click_on '新規作成する'
        expect(page).to have_content 'title'
        expect(page).to have_content '着手'
        expect(page).to have_content 'label_name1'
      end
    end
  end
  describe '検索機能' do
    context 'ラベル検索をした場合' do
      it "検索したラベルのタスクが表示されること" do
        FactoryBot.create(:label3)
        visit new_task_path
        fill_in :task_title, with: "title"
        fill_in :task_content, with: "content"
        fill_in :task_expired_at, with: "002021-05-22"
        find("#task_status").find("option[value='着手']").select_option
        check 'label_name3'
        click_on '新規作成する'
        visit tasks_path
        select 'label_name3'
        # binding.irb
        click_on '検索'
        expect(page).to have_content 'label_name3'
      end
    end
  end
end 