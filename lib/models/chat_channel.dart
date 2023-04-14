//use firestore documents to implement chat channel
import 'package:bitsapp/models/message.dart';

class ChatChannel {
  final String name;
  final List<Message> messages;

  ChatChannel({required this.name,required this.messages});
  
}