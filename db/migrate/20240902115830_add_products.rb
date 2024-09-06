class AddProducts < ActiveRecord::Migration[7.2]
  def change
    Product.create( 
      title: 'Гавайская',
      description: 'This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.',
      price: 350,
      size: 'small',
      is_spicy: false,
      is_veg: true,
      is_best_offer: false,
      path_to_image: '/images/1.jpg')

    Product.create( 
      title: 'Домашняя',
      description: 'This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.',
      price: 450,
      size: 'medium',
      is_spicy: false,
      is_veg: false,
      is_best_offer: true,
      path_to_image: '/images/2.jpg')

    Product.create( 
      title: 'Мясная',
      description: 'This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.',
      price: 550,
      size: 'big',
      is_spicy: true,
      is_veg: false,
      is_best_offer: true,
      path_to_image: '/images/3.jpg')

    Product.create( 
      title: 'Сырная',
      description: 'This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.',
      price: 550,
      size: 'big-xl',
      is_spicy: true,
      is_veg: false,
      is_best_offer: false,
      path_to_image: '/images/4.jpg')
  end
end
