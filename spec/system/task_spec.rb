require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task', content: 'task', expired_at: '002021-05-18', status: 1) }
  let!(:task2) { FactoryBot.create(:task, title: 'task2', content: 'task2', expired_at: '002021-05-20', status: 2) }
  let!(:task3) { FactoryBot.create(:task, title: 'task3', content: 'task3', expired_at: '002021-05-21', status: 3) }
  before do
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in :task_title, with: "title"
        fill_in :task_content, with: "content"
        fill_in :task_expired_at, with: "002021-05-22"
        click_on '新規作成する'
        expect(page).to have_content 'title'
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
        click_on '終了期限でソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task3'
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
        fill_in :search_title, with: "task"
        click_on '検索'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        find("#search_status").find("option[value='未着手']").select_option
        click_on '検索'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルとステータスの両方で検索した場合' do
      it "該当したタスクが表示される" do
        fill_in :search_title, with: "task2"
        find("#search_status").find("option[value='完了']").select_option
        click_on '検索'
        expect(page).to have_content '完了'
      end
    end
  end
end