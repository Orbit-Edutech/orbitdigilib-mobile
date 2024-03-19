import 'package:url_launcher/url_launcher.dart' as launcher;

Future<bool> launchUrl(String path) async {
  final Uri url = Uri.parse(path);
  final bool isSucces = await launcher.launchUrl(
    url,
    mode: launcher.LaunchMode.externalApplication,
  );
  return isSucces;
}

Future<bool> launchMailTo(String email, {String? subject, String? body}) async {
  final Uri url = Uri(
    scheme: "mailto",
    path: email,
    query: "subject=$subject&body=$body",
  );
  final bool isSuccess = await launcher.launchUrl(
    url,
    mode: launcher.LaunchMode.externalApplication,
  );
  return isSuccess;
}
