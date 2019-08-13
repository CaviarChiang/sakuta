import 'dart:convert';

class MessageUtil{
  String formatLogIn(String userId){
      Map<String, String> messageObject = Map<String, String>();
      messageObject['user_id'] = userId;
    return json.encode(messageObject);
  }

  String formatMessage(String message, String targetId){
      Map<String, String> messageObject = Map<String, String>();
      messageObject['receiver_id'] = targetId;
      messageObject['message'] = message;
    return json.encode(messageObject);
  }
}