import 'dart:io';
import 'package:http/http.dart';

class DataManager {

  static String id = '-1';

  static const host = 'http://mrmyyesterday.com';
  static const dbPort = '8080';
  static const chatListQuery = 'chatlist-load?user_id=';
  static const messageHistoryQueryParam1 = 'message-load?sender_id=';
  static const messageHistoryQueryParam2 = '&receiver_id=';

  static String get user1Id => id;
  static set userId (id) {
    DataManager.id = id;
  } 

  static Future<dynamic> logIn(){
    return null;
  }

  static Future<Response> loadChats(String userId){
    //http://mrmyyesterday.com:8080/chatlist-load?user_id=1
    return get(host + ':' + dbPort + '/' + chatListQuery + userId);
  }

  static Future<Response> loadHistory(String userId){
    return get(host + ':' + dbPort + '/' + 
      messageHistoryQueryParam1 + DataManager.user1Id + 
      messageHistoryQueryParam2 + userId);
  }
  
}