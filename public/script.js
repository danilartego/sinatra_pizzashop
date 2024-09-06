
function addToCart(id) {

  var key = 'product_' + id;

  var x = window.localStorage.getItem(key);

  x = x * 1 + 1;

  window.localStorage.setItem(key, x);

  updateBasketInput()
  updateBasketButton()
}


function printCart() {

  let cnt = 0;

  for (let i = 0; i < window.localStorage.length; i++) {

    let key = window.localStorage.key(i); // получаем ключ
    let value = window.localStorage.getItem(key); // получаем значение

    if (key.indexOf('product_') == 0) {
      cnt = cnt + value * 1;
    }
  }

  console.log(cnt);
  return cnt;
}

function updateBasketInput() {
  let orders = getBasket();
  $('#orders_input').val(orders);
  $('#orders_send').val(orders);
}

function updateBasketButton() {
  let orders = 'Корзина (' + printCart() + ')';
  $('#orders_button').val(orders);
}


function getBasket() {

  let orders = '';

  for (let i = 0; i < window.localStorage.length; i++) {

    let key = window.localStorage.key(i); // получаем ключ
    let value = window.localStorage.getItem(key); // получаем значение

    if (key.indexOf('product_') == 0) {
      orders = orders + key + '=' + value + ',';
    }
  }

  console.log(orders);
  return orders;
}


function clearBasket() {
  window.localStorage.clear();

  updateBasketInput();
  updateBasketButton();
}