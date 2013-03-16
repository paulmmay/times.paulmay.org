not_found do
  erb :notfound
end

get '/view' do
	@result = Timesimage.find(:all, :order => "id desc", :limit => 60)
	erb :last20
end