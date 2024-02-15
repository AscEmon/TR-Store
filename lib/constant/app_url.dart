import 'package:tr_store/utils/enum.dart';

enum AppUrl {
  base,
  baseImage,
  products,
  productDetails,
}

extension AppUrlExtention on AppUrl {
  static String _baseUrl = "";
  static String _baseImageUrl = "";

  static void setUrl(UrlLink urlLink) {
    switch (urlLink) {
      case UrlLink.isLive:
        _baseUrl = "https://jsonplaceholder.org/";
        _baseImageUrl = "";

        break;

      case UrlLink.isDev:
        _baseUrl = "https://jsonplaceholder.org/";
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
      case AppUrl.products:
        return "/posts";
      case AppUrl.productDetails:
        return "/posts?id=";

      default:
    }
    return "";
  }
}
