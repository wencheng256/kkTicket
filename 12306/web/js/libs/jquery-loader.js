!(function() {

  // Get any lib=___ param from the query string.
  var library = location.search.match(/[?&]lib=(.*?)(?=&|$)/);

  /* jshint -W060 */
  if (library) {
    document.write('<script src="/js/libs/' + library[1] + '"></script>');
  } else {
    document.write('<script src="/js/jquery.min.js"></script>');
  }
}());
