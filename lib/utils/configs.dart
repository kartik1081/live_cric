import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:in_app_review/in_app_review.dart';

class Configs {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static final FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final InAppReview inAppReview = InAppReview.instance;

  static const String baseURL = "https://cricbuzz-cricket.p.rapidapi.com";
}
