class CheckoutController < ApplicationController
  def index
  	
	t0 = Time.now
  	@current_url = request.original_url

	secret = "dummysecret" ## Advertiser Secret Key

	transaction_id = params[:trans]
	user_id = params[:user]

	products=params[:product]
	amount = params[:amount]

	# encode
	require 'cgi' 
	products = CGI.escape(products)
	amount = CGI.escape(amount)

	postback_url = "http://ipsyresearch.go2cloud.org/aff_lsr?transaction_id=#{transaction_id}&user_id=#{user_id}&adv_sub=#{secret}&adv_sub2=#{products}&amount=#{amount}"
  	puts "[DEBUG] Postback URL: #{postback_url}"

	# sending the conversion link
	require 'nokogiri'
	#require 'open-uri'
	require 'open_uri_redirections'
	doc = Nokogiri::HTML(open(postback_url, :allow_redirections => :all))
	puts "[DEBUG] #{doc}"
	if doc.at('body').text != "success=true;"
		puts "ERROR: problem in sending conversion_url"
		return
	end
	puts "[DEBUG] TIME LAPSED: #{Time.now-t0} seconds"
	
  	redirect_to "http://localhost:3000" # redirects back to ipsyploos dummy site
  end
end
