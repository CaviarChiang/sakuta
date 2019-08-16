import 'dart:convert';

import 'package:sakuta/utils/values.dart';

class MessageUtil{
  String formatLogIn(String userId){
      Map<String, String> messageObject = Map<String, String>();
      messageObject[Values.USER_ID] = userId;
    return json.encode(messageObject);
  }

  String formatMessage(String message, String targetId){
      Map<String, String> messageObject = Map<String, String>();
      messageObject[Values.TARGET_ID] = targetId;
      messageObject[Values.MESSAGE_DATA] = message;
    return json.encode(messageObject);
  }
}
