FactoryBot.define do
  factory :user do
    name { "tora" }
    email { "tora@gmail.com" }
    password { "111111" }
    admin { "一般" }
  end
  factory :admin_user ,class: User do
    name { "kuro" }
    email { "kuro@gmail.com" }
    password { "111111" }
    admin { "管理者" }
  end
end
