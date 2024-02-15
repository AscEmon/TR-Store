import 'package:tr_store/utils/enum.dart';

enum AppUrl {
  base,
  baseImage,

}

extension AppUrlExtention on AppUrl {
  static String _baseUrl = "";
  static String _baseImageUrl = "";

  static void setUrl(UrlLink urlLink) {
    switch (urlLink) {
      case UrlLink.isLive:
        _baseUrl = "";
        _baseImageUrl = "";

        break;

      case UrlLink.isDev:
        _baseUrl = "";
        _baseImageUrl = "";

        break;
      case UrlLink.isLocalServer:
        // set up your local server ip address.
        _baseUrl = "";
        break;
    }
  }

  String get url {
    switch (this) {
       case AppUrl.base:
        return _baseUrl;
      case AppUrl.baseImage:
        return _baseImageUrl;
     
      default:
    }
    return "";
  }
}

