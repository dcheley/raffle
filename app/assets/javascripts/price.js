document.getElementById('entry').oninput = function() {
  var entry = document.getElementById('newEntry').value;
  var entry = parseFloat(entry);

  if (entry % 2 != 0) {
    entry = entry * 2.50 + 0.5;
  } else {
    entry = entry * 2.5;
  }
  finalPrice = currencyFormat(entry);
  document.getElementById('prices').innerHTML = '<p>' + finalPrice + '</p>';

  function currencyFormat(number) {
    var finalPrice = parseFloat(number);
    finalPrice = finalPrice.toFixed(2);
    finalPrice = '$' + finalPrice;
    return finalPrice;
  }
}
