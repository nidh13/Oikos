class ServerExeption implements Exception {
  final String message;


  ServerExeption({this.message='Unexpected Error'});

}