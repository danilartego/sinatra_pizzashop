## Урок 36

продолжение урока по созданию PizzaShop

Дабавление стилей к кнопке "Оформить заказ"

```css
#orders_button {
  background-color: #F8F8F8;
  border: none;
  font-size: 20px;
  padding-top: 10px;
  padding-right: 20px;
  padding-bottom: 10px;
  padding-left: 20px;
  text-decoration: none;

}
```

Добавление параметра к кнопке, чтобы не отправять форму при нажатии  
Выполнение скрипта js выполняеться

```html
<form action="/cart" method="POST"
<button class="btn" id="orders_button" onClick=return cancelOrder()">Очистить</button>
</form>

<script>
  function cancelOrder() {
  alert('Заказ отменен');
  return false;
  }
</script>
```