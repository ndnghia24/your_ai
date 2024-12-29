import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobBannerAdWidget extends StatefulWidget {
  final String adUnitId;

  const AdmobBannerAdWidget({Key? key, required this.adUnitId})
      : super(key: key);

  @override
  _AdmobBannerAdWidgetState createState() => _AdmobBannerAdWidgetState();
}

class _AdmobBannerAdWidgetState extends State<AdmobBannerAdWidget> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: widget.adUnitId, // Thay bằng Ad Unit ID của bạn
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('Failed to load banner ad: ${error.message}');
          _isAdLoaded = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? Container(
            alignment: Alignment.center,
            width: _bannerAd.size.width.toDouble(),
            height: _bannerAd.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd),
          )
        : SizedBox.shrink(); // Không hiển thị gì nếu quảng cáo chưa sẵn sàng
  }
}
