class CheckoutController < ApplicationController
  def index

  	#exec "curl http://strk.cakemarketing.com/?a=#{affiliate_id}&c=#{creative_id}&p=f&s1="

	api_key = 'wSzLLbZyVZm1O9ZKQkzeDmt4wTYTKeC'

  	user_id = "ipsy-user-#{current_user.id}"
	puts "[DEBUG] user_id: #{user_id}"

  	affiliate_id = params[:affiliate_id]
  	creative_id = params[:creative_id]


# Generate Unique URL
  	url = "http://strk.cakemarketing.com/?a=#{user_id}&c=#{creative_id}&p=f&s1="
	puts "[DEBUG] Created UNIQUE URL: #{url}"

	# encode the Unique URL to send as parameter to the redirect site
	require 'cgi'
	encoded_url = CGI.escape(url)
	puts "[DEBUG] Encoded UNIQUE URL: #{encoded_url}"

	# TODO sample url site
	#url = "www.shop.com"
	url = "http://localhost:3001"
	url = "#{url}/unique_url=#{encoded_url}"


	# TODO redirect to the shopping site

  	redirect_to "#{url}"

######## shopping site receives the unique URL

	# get the parameter in unique_url
	unique_url = encoded_url

	# something to decode the URL
	decoded_url = CGI.unescape(unique_url)
	puts "[DEBUG] Decoded UNIQUE URL: #{decoded_url}"

	# dummy data
	price = "12.99"
	product = "Lipstick"
	brand = "mac"
	transaction_id = "asdf1234"
	secret = "secretkey"
	
	# upon successful payment in checkout

	# create Conversion link
	t0 = Time.now
	conversion_url = "#{decoded_url}&p=f&s1=#{price}&s2=#{product}&s3=#{brand}&s4=#{transaction_id}&s5=#{secret}"
	puts "In Shopping Site"
	puts "[DEBUG] price: #{price}"
	puts "[DEBUG] product: #{product}"
	puts "[DEBUG] brand: #{brand}"
	puts "[DEBUG] transaction_id: #{transaction_id}"
	puts "[DEBUG] secret: #{secret}"
	puts "[DEBUG] conversion_url: #{conversion_url}"

	# sending the conversion link
	xml = Nokogiri::XML(open(conversion_url))
	if xml.search('success').text == "false"
		puts "ERROR: problem in sending conversion_url"
		return
	end
	puts xml
	puts "after #{Time.now-t0} seconds"
	#affiliate_id = xml.search('affiliate_id').text
  	
  end
end
