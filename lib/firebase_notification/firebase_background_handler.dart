import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {

  // android
  //await Firebase.initializeApp();
  //print(message.messageId);
   // ios
  await Firebase.initializeApp(
    options: kIsWeb
        ? throw UnsupportedError('Web not supported')
        : FirebaseOptions(
      apiKey: 'AIzaSyCXNWG95tMBd0cMt3pH87EFC-3GBEazs0c',
      appId: '1:206102003007:ios:d4862ddce17eea412c278a',
      messagingSenderId: '206102003007',
      projectId: 'marsa-hr',
      storageBucket: 'marsa-hr.firebasestorage.app',
      iosBundleId: 'com.marsa.marsa-hr', // لازم يكون زي Xcode
    ),
  );
  print('Handling a background message: ${message.messageId}');
}
  // هنا تحطي أي logic بسيط


