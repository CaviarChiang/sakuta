import 'package:http/http.dart';

class DataManager {
  //mmy.com:8080
  final String host = 'http://18.222.226.32';
  final String chatListQuery = 'chatlist-load?user_id=';
  final String messageHistoryQueryParam1 = 'message-load?sender_id=';
  final String messageHistoryQueryParam2 = '&receiver_id=';

  //final String relayServer = 'ws://172.31.20.216:5000';
  final String relayServer = 'ws://mrmyyesterday.com:5000';

  Future<dynamic> logIn(){
    return null;
  }

  Future<Response> loadChats(String userId){
    //http://mrmyyesterday.com:8080/chatlist-load?user_id=1
    return get(host + '/' + chatListQuery + userId);
  }

  Future<Response> loadHistory(String userId, String targetId){
    return get(host + '/' + 
      messageHistoryQueryParam1 + userId + 
      messageHistoryQueryParam2 + targetId);
  }  
}
