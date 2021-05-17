# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'test1' }
    content { 'test1' }
  end
  factory :task2, class: Task do
    title { 'test2' }
    content { 'test2' }
  end
end