class CheckoutController < ApplicationController
  def index
  	
  	# PRE-GENERATED UNIQUE LINK: http://strk.cakemarketing.com/?a=1&c=98&s1=

  	#user_id = params[:user_id]
	#puts "[DEBUG] user_id: #{user_id}"

  	#affiliate_id = params[:affiliate_id]
  	#puts "[DEBUG] affiliate_id: #{affiliate_id}"

  	#creative_id = params[:creative_id]
  	#puts "[DEBUG] creative_id: #{creative_id}"

  	@current_url = request.original_url
  	#puts "[DEBUG] ORIGINAL URL: #{original_url}"

  	encoded_url = params[:encoded_url]
  	puts "[DEBUG] ORIGINAL URL: #{encoded_url}"


  	encoded_url = encoded_url.split("=",2)
  	encoded_url = encoded_url[1]

	# something to decode the URL
	require 'cgi'
	decoded_url = CGI.unescape(encoded_url)
	puts "[DEBUG] Decoded UNIQUE URL: #{decoded_url}"


	# sample shop url
	url = "http://localhost:3001"					#dummy shop site
	full_url = "#{url}/unique_url=#{encoded_url}"	#called by ipsyploos-demo



	# parse full_url to get url



	# dummy data of product bought from shop site
	price = "100.00"
	product = "Lipstick"
	brand = "mac"
	transaction_id = "asdf1234"
	secret = "secretkey"
	
	# upon successful payment in checkout

	# create Conversion link
	t0 = Time.now
	cake_url = decoded_url
	conversion_url = "#{cake_url}&s1=#{price}&s2=#{product}&s3=#{brand}&s4=#{transaction_id}&s5=#{secret}"
	puts "Purchase Details"
	puts "[DEBUG] price: #{price}"
	puts "[DEBUG] product: #{product}"
	puts "[DEBUG] brand: #{brand}"
	puts "[DEBUG] transaction_id: #{transaction_id}"
	puts "[DEBUG] secret: #{secret}"
	puts "[DEBUG] conversion_url: #{conversion_url}"

	# sending the conversion link
	require 'nokogiri'
	#require 'open-uri'
	require 'open_uri_redirections'
	xml = Nokogiri::XML(open(conversion_url, :allow_redirections => :all))
	
	if xml.search('success').text == "false"
		puts "ERROR: problem in sending conversion_url"
		return
	
	end
	
	#puts "[DEBUG] #{xml}"
	puts "[DEBUG] TIME LAPSED: #{Time.now-t0} seconds"
	
  	redirect_to "http://localhost:3000" # redirects back to ipsyploos dummy site
  end
end
