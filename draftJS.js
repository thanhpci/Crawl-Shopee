javascript: void (function () {function copyToClipboard(text) {var dummy = document.createElement('textarea');document.body.appendChild(dummy);dummy.value = text;dummy.select();document.execCommand('copy');document.body.removeChild(dummy);}function checkStar(n) {var items = document.getElementsByClassName('col-xs-2-4 shopee-search-item-result__item');var stars = items[n].querySelectorAll('.shopee-rating-stars__lit');var totalWidth = 0;for (var i = 0; i < stars.length; i++) {var starWidth = stars[i].style.width;var widthValue = parseInt(starWidth);totalWidth += widthValue;}var averageStars = totalWidth / 100;return averageStars;}copyToClipboard(checkStar(index));})();




void(function(){function copyToClipboard(text) {var dummy = document.createElement('textarea');document.body.appendChild(dummy);dummy.value = text;dummy.select();document.execCommand('copy');document.body.removeChild(dummy);}function checkStar(n) {var items = document.getElementsByClassName('col-xs-2-4 shopee-search-item-result__item');var stars = items[n].querySelectorAll('.shopee-rating-stars__lit');var totalWidth = 0;for (var i = 0; i < stars.length; i++) {var starWidth = stars[i].style.width;var widthValue = parseInt(starWidth);totalWidth += widthValue;}var averageStars = totalWidth / 100;return averageStars;}index = 6;copyToClipboard(checkStar(index));})();

function copyToClipboard(text) {var dummy = document.createElement('textarea');document.body.appendChild(dummy);dummy.value = text;dummy.select();document.execCommand('copy');document.body.removeChild(dummy);}function checkStar(n) {var items = document.getElementsByClassName('col-xs-2-4 shopee-search-item-result__item');var stars = items[n].querySelectorAll('.shopee-rating-stars__lit');var totalWidth = 0;for (var i = 0; i < stars.length; i++) {var starWidth = stars[i].style.width;var widthValue = parseInt(starWidth);totalWidth += widthValue;}var averageStars = totalWidth / 100;return averageStars;}index = 6;copyToClipboard(checkStar(index));










function copyToClipboard(text) {
  var dummy = document.createElement('textarea');
  document.body.appendChild(dummy);
  dummy.value = text;
  dummy.select();
  document.execCommand('copy');
  document.body.removeChild(dummy);
}

function checkStar(n) {
  var items = document.getElementsByClassName(
    'col-xs-2-4 shopee-search-item-result__item'
  );
  var stars = items[n].querySelectorAll('.shopee-rating-stars__lit');
  var totalWidth = 0;
  for (var i = 0; i < stars.length; i++) {
    var starWidth = stars[i].style.width;
    var widthValue = parseInt(starWidth);
    totalWidth += widthValue;
  }
  var averageStars = totalWidth / 100;
  return averageStars;
}
copyToClipboard(checkStar(index));


void(function(){
  for(let i = 0; i < 50; i++){
    console.log(i);
  }
})();
