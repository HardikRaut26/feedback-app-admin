import 'package:flutter/material.dart';
import 'package:admin_app1/supabase_config.dart';
import 'package:admin_app1/feedback_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSupabase();
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Feedback Viewer',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const FeedbackListScreen(),
    );
  }
}
