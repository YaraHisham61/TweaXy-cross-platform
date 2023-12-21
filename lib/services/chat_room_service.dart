import 'dart:developer';
import 'dart:io';

import 'package:chatview/chatview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/utilities/tweets_utilities.dart';

class ChatRoomService {
  final Dio dio;
  final String baseUrl = 'https://tweaxybackend.mywire.org/api/v1/';
  late String userID;
  ChatRoomService(this.dio);
  Future<List<Message>> getMessages(String id, int pageOffset) async {
    Response response;
    String? token;
    try {
      List<String> s = await loadPrefs();
      token = s[1];
      userID = s[0];
    } catch (e) {
      log(e.toString());
    }
    try {
      response = await Api.getwithToken(
          url: '${baseUrl}conversations/$id?limit=20&offset=$pageOffset',
          token: token);

      return messageformat(response);
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('get old messages error ');
    }
  }

  Future<dynamic> sendMessage(String text, String media) async {
    File imageFile = File(media);
    List<int> imageBytes = await imageFile.readAsBytes();
  }

  List<Message> messageformat(Response response) {
    var items = response.data["data"]["items"];
    List<Message> messages = [];
    for (var i in items) {
      String sendByid = userID == i["senderId"] ? userID : "2";
      String mess = i["media"] == [] ? i["text"] : i["medai"];
      MessageType messtype =
          i["media"] == [] ? MessageType.text : MessageType.image;
      MessageStatus state =
          i["seen"] == true ? MessageStatus.read : MessageStatus.delivered;

      messages.add(Message(
          status: state,
          messageType: messtype,
          message: mess,
          createdAt: DateTime.parse(i["createdDate"]).toLocal(),
          sendBy: sendByid));
    }
    return messages;
  }

  Future<String> firstConversation(String username) async {
    String returndata = "";
    Response response;
    String? token;
    try {
      List<String> s = await loadPrefs();
      token = s[1];
    } catch (e) {
      log(e.toString());
    }
    try {
      response = await Api.post(
          body: {"UUID": username},
          url: '${baseURL}conversations',
          token: token);
      if (response.statusCode == 201) {
        returndata = response.data["data"]["conversationID"];
      } else if (response.statusCode == 200) {
        returndata = response.data["data"]["conversation"]["id"];
      }
      return returndata;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('create conservation error ');
    }
  }
}
