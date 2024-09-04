/**
 * Increases a counter stored in local storage and alerts it.
 * The counter is stored under the key 'score2'.
 * If the key does not exist, it is created with the value 1.
 * Otherwise, it is increased by 1.
 */
function something() {
  var x = window.localStorage.getItem('score2');
  x = x * 1 + 1;
  window.localStorage.setItem('score2', x);

  alert(x);
}

// Function that adds a product to the cart by its id
// It uses a local storage to keep track of the number of products
// in the cart
// @param id - id of the product to add to the cart
function addToCart(id) {
  // The key for the local storage
  var key = 'product' + id;
  // Get the current number of products in the cart
  var x = window.localStorage.getItem(key);
  // Increment the number of products
  x = x * 1 + 1;
  // Save the new number of products in the cart
  window.localStorage.setItem(key, x);
}

/**
 * Prints the total number of products in the cart
 * using the local storage to retrieve the numbers
 * of products in the cart.
 */
function printCart() {
  const hh = window.localStorage
  const sum = Object.values(hh).reduce((accumulator, currentValue) => accumulator + Number(currentValue), 0);

  console.log(sum);
}