import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'YOUR_URL';
const supabaseKey = 'YOUR_ANONKEY';

Future<void> initSupabase() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
}
