enum KAssetName {
  oil,
  close_bottom,
}

extension AssetsExtention on KAssetName {
  String get imagePath {
    String _rootPath = 'assets';
    String _svgDir = '$_rootPath/svg';
    String _imageDir = '$_rootPath/images';

    switch (this) {
      case KAssetName.oil:
        return "$_imageDir/oil.png";
      case KAssetName.close_bottom:
        return "$_svgDir/close_bottom.svg";

      default:
        return "";
    }
  }
}

