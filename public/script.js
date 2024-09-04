function something() {
  var x = window.localStorage.getItem('score2');
  x = x * 1 + 1;
  window.localStorage.setItem('score2', x);

  alert(x);
}

function addToCart(id) {
  var key = 'product' + id;
  var x = window.localStorage.getItem(key);
  x = x * 1 + 1;
  window.localStorage.setItem(key, x);
}
