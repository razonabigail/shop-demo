class CheckoutController < ApplicationController
  def index
  	
  	# PRE-GENERATED UNIQUE LINK: http://strk.cakemarketing.com/?a=1&c=98&s1=

  	@current_url = request.original_url
  	#puts "[DEBUG] ORIGINAL URL: #{original_url}"

  	original_link = params[:original_link]
  	puts "[DEBUG] ORIGINAL URL: #{original_link}"


  	encoded_url = original_link.split("=",2)
  	encoded_url = encoded_url[1]

	# something to decode the URL
	require 'cgi'
	cake_url = CGI.unescape(encoded_url)
	puts "[DEBUG] DECODED UNIQUE CAKE URL FROM IPSYPLOOS-DEMO: #{cake_url}"


	# sample shop url
	shop_url = "http://localhost:3001"					#dummy shop site
	full_shop_url = "#{shop_url}/unique_url=#{encoded_url}"	#called by ipsyploos-demo



	# dummy data of product bought from shop site
	price = "123.00"
	product = "Lipstick"
	brand = "mac"
	transaction_id = "asdf1234"
	secret = "secretkey"
	
	# upon successful payment in checkout

	# create Conversion link
	t0 = Time.now
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
