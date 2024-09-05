#encoding: utf-8
require "rubygems"
require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"

set :database, { adapter: "sqlite3", database: "pizzashop.db" }

class User < ActiveRecord::Base
  has_many :orders
end

class Product < ActiveRecord::Base
  has_many :orders
end

class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :product, through: :order_items
end

class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
end

before do
  @products = Product.all
  @users = User.all
  @orders = Order.all
  @order_items = OrderItem.all
end

get "/" do
  erb :index
end

get "/about" do
  erb :about
end

get "/products" do
  erb :products
end

post "/cart" do
  orders_string = params[:orders]
  hash = orders_string.split(",").map { |pair| key, value = pair.split("="); [key, value.to_i] }.to_h
  @orders_hash = hash.transform_keys { |key| key.gsub(/\D/, "").to_i }

  erb :cart
end

get "/order" do
  erb :order
end

post "/order" do
  @user = User.new params[:user]
  @user.save

  orders_string = params[:orders]
  hash = orders_string.split(",").map { |pair| key, value = pair.split("="); [key, value.to_i] }.to_h
  @orders_hash = hash.transform_keys { |key| key.gsub(/\D/, "").to_i }

	@order = Order.new

  @products.each do |product|
		
    @orders_hash.each do |product_id, value|
      if product.id == product_id
        
        @order.user_id = @user.id
        @order.save
				@order_item = OrderItem.new
        @order_item.order_id = @order.id
        @order_item.product_id = product.id
        @order_item.value = value
        @order_item.save
      end
    end
  end

  redirect to :order
end
