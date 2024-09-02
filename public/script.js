function something() {
  var x = window.localStorage.getItem('score');

  window.localStorage.setItem('score', 555);

  alert(x);
}