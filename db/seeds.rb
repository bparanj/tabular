100.times do
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              title: Faker::Job.title,
              city: Faker::Address.city,
              age: rand(18..65),
              start_date: Faker::Date.birthday(1, 35).strftime('%Y/%m/%d'),
              salary: "$" + "#{rand(25000..200000)}")
end