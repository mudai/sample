user = User.first

date = Date.today

100.times do |i|
  mh = user.monitoring_histories.new
  mh.number_of_steps = rand(100)
  mh.body_weight = rand(200)
  mh.recorded_on = date
  date = date.prev_day
  mh.save
end
