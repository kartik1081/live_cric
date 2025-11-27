import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Configs {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static const String baseURL = "https://cricbuzz-cricket.p.rapidapi.com";
}
