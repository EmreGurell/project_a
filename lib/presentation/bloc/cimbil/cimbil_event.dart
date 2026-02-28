abstract class CimbilEvent {}

class SendMessage extends CimbilEvent {
  final String text;
  SendMessage(this.text);
}

class ClearChat extends CimbilEvent {}
