# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'task_title' }
    content { 'task_content' }
    expired_at { '2021-04-01 01:11:00' }
    status { 1 }
    priority { 1 }
    association :user
  end
  factory :task2, class: "Task" do
    title { 'task2_title' }
    content { 'task2_content' }
    expired_at { '2021-06-01 01:11:00' }
    status { 2 }
    priority { 2 }
    association :user
  end
  factory :task3, class: "Task" do
    title { 'task3_title' }
    content { 'task3_content' }
    expired_at { '2021-05-01 01:11:00' }
    status { 3 }
    priority { 3 }
    association :user
  end
end