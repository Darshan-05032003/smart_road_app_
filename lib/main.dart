import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:smart_roadside/views/common/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCJL647_5C6W9YQZ0Gjxybg1kBr7r6ZuPI",
      appId: "1:348117599137:android:c9a04437715db2605cc1e0",
      messagingSenderId: "348117599137",
      projectId: "app-roadside-a70b4",
      storageBucket: "app-roadside-a70b4.firebasestorage.app",
    ),
  );
  runApp(VoiceAssistantApp());
}

class VoiceAssistantApp extends StatelessWidget {
  const VoiceAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal AI Agent',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
