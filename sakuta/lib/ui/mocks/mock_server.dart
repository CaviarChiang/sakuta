class MockServer {

  static Future<String> loadList(){
    var future = Future.delayed(Duration(seconds: 1), () => 'caviar sakuta');
    return future;
  }
}