#encoding: utf-8
require "rubygems"
require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"


set :database, { adapter: "sqlite3", database: "pizzashop.db" }
enable :sessions

class User < ActiveRecord::Base
  # Валидация поля из формы
  validates :name, presence: true
  validates :phone, presence: true
  validates :adress, presence: true

  # Отношение Пользователя к многим заказам
  has_many :orders
end

class Product < ActiveRecord::Base

  # Отношение Продукта к многим заказам
  has_many :orders
end

class Order < ActiveRecord::Base

  # Отношение Заказа к одному Пользователю
  belongs_to :user

  # Отношение Заказа к многим Заказ-Количество
  has_many :order_items

  # Отношение Заказа к многим Продуктам через Заказ-Количество
  has_many :product, through: :order_items
end

class OrderItem < ActiveRecord::Base

  # Отношение Закаказ-Количество к одному Заказу
  belongs_to :order

  # Отношение Заказ-Количество к одному Продукту
  belongs_to :product
end

# Назначение переменных перед каждым запросом
before do
  @products = Product.all
  @users = User.all
  @orders = Order.all
  @order_items = OrderItem.all
end

get "/" do
  erb :index
end

# Вывод списка продуктов
get "/products" do
  erb :products
end

# Вывод корзины
get "/cart" do

  @user = session[:user]
  @orders_hash = session[:orders_hash]
  @error = session[:error]

  erb :cart
end

# Обработчик формы добавления в корзину
post "/cart" do
  # Получение данных о заказе
  orders_string = params[:orders]

  # Преобразование строки в хеш
  @orders_hash = parce_orders(orders_string)

  erb :cart
end

# Вывод формы заказов
get "/order" do

  # Создание пустого хеша
  @user_sum_values = {}
  @user_sum_price = {}

  # Получение данных о пользователе с обратной сортировкой
  @users = User.order(id: :desc)

  # Подсчет общей суммы и общего колличества
  @users.each do |user|
    @user_sum_values[user.id] = 0
    @user_sum_price[user.id] = 0
    @orders.each do |order|
      if order.user_id == user.id
        @order_items.each do |item|
          if order.id == item.order_id
            @user_sum_values[user.id] += item.value
            @user_sum_price[user.id] += item.product.price * item.value
          end
        end
      end
    end
  end

  erb :order
end

# Запись заказа в базу данных с учетом Заказчика и заказанных продуктов
post "/order" do
  # Получение данных о пользователе
  @user = User.new params[:user]
  
  # Получение данных о заказе
  orders_string = params[:orders]
  # Преобразование строки в хеш
  @orders_hash = parce_orders(orders_string)

  # Проверка на пустоту и сохранение
  if @user.save
    
    session[:user] = nil
    session[:orders_hash] = nil
  else
    session[:user] = @user
    session[:orders_hash] = @orders_hash
    session[:error] = @user.errors.full_messages.first
    redirect to :cart
  end

  # Создание заказа
  @order = Order.new

  # Добавление продуктов в заказ
  @products.each do |product|
    # Проверка наличия продукта в заказе
    @orders_hash.each do |product_id, value|
      # Если есть такой продукт
      if product.id == product_id
        # Добавление id заказчика в заказ
        @order.user_id = @user.id
        @order.save

        # Создание списка с количеством заказанных продуктов
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

# Метод преобразования строки в хеш с числовыми ключами
def parce_orders(order)

  # Преобразование строки в хеш
  hash = order.split(",").map { |pair| key, value = pair.split("="); [key, value.to_i] }.to_h
  # Преобразование хеша в хеш с числовыми ключами
  order_hash = hash.transform_keys { |key| key.gsub(/\D/, "").to_i }
  order_hash
end
