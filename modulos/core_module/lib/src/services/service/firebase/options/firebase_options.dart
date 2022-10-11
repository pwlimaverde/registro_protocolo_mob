import 'package:dependencies_module/dependencies_module.dart';

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA4xPQTTDgbeS9mxZB_e3yQcUUdu0Tjxvg',
    appId: '1:763738041874:web:87d837e4a3706edab272cb',
    messagingSenderId: '763738041874',
    projectId: 'registro-protocolo-mob',
    authDomain: 'registro-protocolo-mob.firebaseapp.com',
    storageBucket: 'registro-protocolo-mob.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPB_y4EpPZ3Xe0rWvvyhiaFsTfF_N9M50',
    appId: '1:763738041874:android:5dd04ec3b3e79d12b272cb',
    messagingSenderId: '763738041874',
    projectId: 'registro-protocolo-mob',
    storageBucket: 'registro-protocolo-mob.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKH3UesE07wRjmuH7mHBfB919MGpxr3do',
    appId: '1:763738041874:ios:425b1f6ff7c2a061b272cb',
    messagingSenderId: '763738041874',
    projectId: 'registro-protocolo-mob',
    storageBucket: 'registro-protocolo-mob.appspot.com',
    iosClientId:
        '763738041874-e4q8c73k1igqk6f3snvh4ke7ks4m5lbi.apps.googleusercontent.com',
    iosBundleId: 'br.com.registroprotocolomob.appClienteRegistroProtocoloMob',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDKH3UesE07wRjmuH7mHBfB919MGpxr3do',
    appId: '1:763738041874:ios:425b1f6ff7c2a061b272cb',
    messagingSenderId: '763738041874',
    projectId: 'registro-protocolo-mob',
    storageBucket: 'registro-protocolo-mob.appspot.com',
    iosClientId:
        '763738041874-e4q8c73k1igqk6f3snvh4ke7ks4m5lbi.apps.googleusercontent.com',
    iosBundleId: 'br.com.registroprotocolomob.appClienteRegistroProtocoloMob',
  );
}
