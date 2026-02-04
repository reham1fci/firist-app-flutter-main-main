import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {

  // لازم
  await Firebase.initializeApp();

  // هنا تحطي أي logic بسيط
  print(message.messageId);
}
