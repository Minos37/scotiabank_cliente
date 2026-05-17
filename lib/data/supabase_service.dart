import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const String supabaseUrl = 'https://hvczqkxylhwkhqexqrkk.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_2qxSRjnm0mo5VPbDkVbOkQ_NjACig7W';

  static final SupabaseClient client = Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  // Auth
  static Future<AuthResponse> signUp(String email, String password) async {
    return await client.auth.signUp(email: email, password: password);
  }

  static Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth.signInWithPassword(email: email, password: password);
  }

  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  static User? getCurrentUser() {
    return client.auth.currentUser;
  }

  // Generic read
  static Future<List<Map<String, dynamic>>> read(String table) async {
    return await client.from(table).select();
  }

  // Generic insert
  static Future<void> insert(String table, Map<String, dynamic> data) async {
    await client.from(table).insert(data);
  }

  // Generic update
  static Future<void> update(String table, Map<String, dynamic> data, String id) async {
    await client.from(table).update(data).eq('id', id);
  }

  // Generic delete
  static Future<void> delete(String table, String id) async {
    await client.from(table).delete().eq('id', id);
  }
}
