import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prima_studio/firebase_options.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseService dbService = FirebaseService();

  dbService.read();
}

class FirebaseService {
  final db = FirebaseFirestore.instance;

  void read() async {
    await db.collection("film").get().then((event) {});
  }
}

    // title = json['title'];
    // genre = json['genre'];
    // thumbnail = json['thumbnail'];
    // synopsis = json['synopsis'];
    // video = json['video'];