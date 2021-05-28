require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user_id: user.id) }
  let!(:task2) { FactoryBot.create(:task2, user_id: user.id) }
  let!(:task3) { FactoryBot.create(:task3, user_id: user.id) }
  before do
    visit new_session_path
    fill_in :session_email, with: "tora@gmail.com"
    fill_in :session_password, with: "111111"
    click_on 'ログイン'
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in :task_title, with: "title"
        fill_in :task_content, with: "content"
        fill_in :task_expired_at, with: "002021-05-22"
        find("#task_status").find("option[value='着手']").select_option
        click_on '新規作成する'
        expect(page).to have_content 'title'
        expect(page).to have_content '着手'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task3'
      end
    end
    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限の遅いタスクが一番上に表示される' do
        click_on '終了期限 🔽'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task2_title'
      end
    end
    context 'タスクが優先順位の高い順に並んでいる場合' do
      it '優先順位の高いタスクが一番上に表示される' do
        click_on '優先順位 🔽'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end
  describe '検索機能' do
    context 'タイトル検索をした場合' do
      it "検索したタイトルのタスクが表示されること" do
        visit tasks_path
        fill_in :search_title, with: "3"
        click_on '検索'
        expect(page).to have_content 'task3'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        find("#search_status").find("option[value='未着手']").select_option
        click_on '検索'
        expect(page).to have_content 'task'
      end
    end
    context 'タイトルとステータスの両方で検索した場合' do
      it "該当したタスクが表示される" do
        fill_in :search_title, with: "3"
        find("#search_status").find("option[value='完了']").select_option
        click_on '検索'
        expect(page).to have_content 'task3'
        expect(page).to have_content '完了'
      end
    end
  end
end 