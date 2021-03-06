require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  let(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user_id: user.id) }
  let!(:task2) { FactoryBot.create(:task2, user_id: user.id) }
  let!(:task3) { FactoryBot.create(:task3, user_id: user.id) }
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: '失敗テスト', expired_at: '002021-05-18', status: 1, user_id: user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        # binding.irb
        task = Task.new(title: 'content', content: '', expired_at: '002021-05-18', status: 1, user_id: user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', content: '成功テスト', expired_at: '002021-05-18', status: 1, user_id: user.id)
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task', content: 'task', expired_at: '002021-05-18', status: 1, user_id: user.id) }
    let!(:task2) { FactoryBot.create(:task, title: 'name', content: 'task2', expired_at: '002021-05-20', status: 2, user_id: user.id) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_title('task')).to include(task)
        expect(Task.search_title('task')).not_to include(task2)
        expect(Task.search_title('task').count).to eq 2
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('未着手')).to include(task)
        expect(Task.search_status('未着手')).not_to include(task2)
        expect(Task.search_status('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('name')).to include(task2)
        expect(Task.search_status('着手')).to include(task2)
        expect(Task.search_title('name')).not_to include(task)
        expect(Task.search_status('着手')).not_to include(task)
        expect(Task.search_title('name').count).to eq 1
        expect(Task.search_status('着手').count).to eq 1
      end
    end
  end
end