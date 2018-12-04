namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task all: [:fake_user, :fake_post]

  task fake_user: :environment do
    #User.destroy_all
    5.times do |i|
      name = FFaker::Name::first_name
      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "123456",
        tel: "0912345678"
      )

      user.save!
      puts user.name
    end
  end

  task fake_post: :environment do
      3.times do |i|
        Post.create!(title: FFaker::Lorem.characters(character_count = 15),
          description: FFaker::Lorem.characters(character_count = 50),
        )
    end
    puts "have created fake posts"
  end

end
