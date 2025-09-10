import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> supabaseInitialization() async {
  await Supabase.initialize(
    url: 'https://nghpqtkubcdilzqurcit.supabase.co',
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5naHBxdGt1YmNkaWx6cXVyY2l0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTcxNTk0MDQsImV4cCI6MjA3MjczNTQwNH0.SAbhyVgob00q9Df8-N7ibVfG1PQg45cOuQmAJIzvnh8',
  );
}
