import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:review_app/data/controller/auth_Controller.dart';
import 'package:review_app/review_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  // INITIALIZE SUPABASE
  // await Supabase.initialize(url: dotenv.env['SUPABASE_URL'] ?? '', anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '');
  await Supabase.initialize(url: 'https://gqjabbghwenwpepzjtej.supabase.co', anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdxamFiYmdod2Vud3BlcHpqdGVqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk5ODcxNTAsImV4cCI6MjA2NTU2MzE1MH0.o0zbsXrflIjP0wPwY_MbNl-yjUPXiu3R86e0nNsAna0');
  
  // AUTH CONTROLLER
  Get.put(AuthController());
  
  runApp(const ReviewApp());
}

