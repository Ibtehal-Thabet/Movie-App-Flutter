import 'package:movieflutter/apikey.dart';
// import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void auth_main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  Supabase.initialize(
    url: 'https://' + projectKey + '.supabase.co',
    anonKey: supabaseApiKey,
  );

  final cloud = Supabase.instance.client;
  final session = cloud.auth.currentSession;
  // runApp();
}
