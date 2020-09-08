import 'dart:async';
import 'dart:io';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'ads_controller.g.dart';

class AdsController = _AdsControllerBase with _$AdsController;

abstract class _AdsControllerBase extends Disposable with Store {
  /*** AdsController Criado para aumentar a monetização e deixar você ricão ***/
  ///
  /// 0 MONETIZAÇÃO DESATIVADA
  /// 1 ADMOB
  /// 2 FACE
  /// 3 ADMOB / FACE
  /// 4 FACE / ADMOB
  ///
  /// 6 STARTAPP
  ///
  int adsType = 0;
  int timeToShow = 15;
  bool forceRepeatAdnetwork = true;

  /// Strings dos anuncios
  /// Admob ID's
  // static String admobAppId =
  //     Platform.isAndroid ? "ca-app-pub-8977784514247877~5257163206" : "";
  // static String admobInterstitialId =
  //     Platform.isAndroid ? "ca-app-pub-8977784514247877/5065591512" : "";
  // static String admobBannerId =
  //     Platform.isAndroid ? "ca-app-pub-8977784514247877/6378673183" : "";
  static String admobAppId = Platform.isAndroid ? FirebaseAdMob.testAppId : "";
  static String admobInterstitialId =
      Platform.isAndroid ? InterstitialAd.testAdUnitId : "";
  static String admobBannerId = Platform.isAndroid ? BannerAd.testAdUnitId : "";

  /// Facebook ID's
  static String faceInterstitialId = Platform.isAndroid
      ? "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617"
      : "";
  static String faceBannerId = Platform.isAndroid
      ? "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047"
      : "";

  /// NÃO FUTRICAR NESSAS VAR'S
  InterstitialAd admobInterstitial;

  /// NÃO ALTERAR
  @observable
  int adBannerToShow = 0;

  /// NÃO ALTERAR || DONT REMOVE AND FUTRICATION
  /// NÃO ALTERAR
  @action
  void updateAdBannerToShow(int nState) => adBannerToShow = nState;

  /// NÃO ALTERAR
  /// defaultNetwork (0: nenhum | 3: admob | 4: facebook) NÃO MEXER || DONT REMOVE
  int defaultNetwork = 0;
  Timer timer;
  bool showInterstitialTimer = true;
  int adInterstitialState = 1;
  int adnetworkToShow = 0;
  int tryRequestAd = 0;
  int primeiraCall = 0;
  bool failRequestBannerFace = false;
  bool failRequestBannerAdmob = false;
  updateStateInterstitial(int nState) => adInterstitialState = nState;
  updateAdNetworkToShow(int nState) => adnetworkToShow = nState;
  updateShowInterstitialTimer(bool nState) => showInterstitialTimer = nState;

  /// É IMUTAVÉL EM MISERAVEL...
  static BannerAd admobBanner;
  static FacebookBannerAd facebookBanner;

  BannerAd createBannerAdmob() => BannerAd(
        adUnitId: admobBannerId,
        size: AdSize.smartBanner,
        listener: (MobileAdEvent event) {
          print("BannerAd event is $event");
          if (event == MobileAdEvent.loaded) {
            if (adsType == 3 || adsType == 4 || adsType == 1) {
              updateAdBannerToShow(3);
            }
          }

          if (event == MobileAdEvent.failedToLoad) {
            tryRequestAd = tryRequestAd++;
            updateAdBannerToShow(0);
            if (adsType == 3 || adsType == 4) {
              if (forceRepeatAdnetwork) failRequestBannerAdmob = true;
              admobBanner?.dispose();
              admobBanner = null;
              facebookBanner = createBannerFace();
            }
          }
        },
      );

  FacebookBannerAd createBannerFace() => FacebookBannerAd(
        placementId: faceBannerId, //testid
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
          if (result == BannerAdResult.LOADED) {
            if (adsType == 3 || adsType == 4 || adsType == 2) {
              updateAdBannerToShow(4);
            }
            tryRequestAd = 0;
          }

          if (result == BannerAdResult.ERROR) {
            tryRequestAd = tryRequestAd++;
            updateAdBannerToShow(0);
            if (adsType == 3 || adsType == 4) {
              if (forceRepeatAdnetwork) failRequestBannerFace = true;
              facebookBanner = null;
              admobBanner = createBannerAdmob()
                ..load()
                ..show();
            }
          }
        },
      );

  Future<bool> createInterstitialAdFace() =>
      FacebookInterstitialAd.loadInterstitialAd(
        placementId:
            faceInterstitialId, //"IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617" YOUR_PLACEMENT_ID
        listener: (result, value) {
          print(">> FAN > Interstitial Ad: $result --> $value");
          if (result == InterstitialAdResult.LOADED) {
            updateStateInterstitial(1);
            tryRequestAd = 0;
          }

          if (result == InterstitialAdResult.DISMISSED) {
            updateStateInterstitial(0);
            if (adsType == 3 || adsType == 4 || adsType == 5) {
              if (!forceRepeatAdnetwork) updateAdNetworkToShow(3);
            }
            updateShowInterstitialTimer(false);
          }

          if (result == InterstitialAdResult.ERROR) {
            updateStateInterstitial(0);
            tryRequestAd = tryRequestAd++;
            if (adsType == 3 || adsType == 4 || adsType == 5) {
              updateStateInterstitial(0);
              updateAdNetworkToShow(3);
              loadInterstitial();
            }
          }
        },
      );

  InterstitialAd interstitialAdAdmob() => InterstitialAd(
        adUnitId: admobInterstitialId,
        listener: (MobileAdEvent event) {
          print("admobInterstitial event is $event");
          if (event == MobileAdEvent.loaded) {
            updateStateInterstitial(1);
            tryRequestAd = 0;
          }

          if (event == MobileAdEvent.closed) {
            debugPrint("admobInterstitial closed");
            updateStateInterstitial(0);
            if (adsType == 3 || adsType == 4 || adsType == 5) {
              if (!forceRepeatAdnetwork) updateAdNetworkToShow(4);
            }
            updateShowInterstitialTimer(false);
          }

          if (event == MobileAdEvent.failedToLoad) {
            tryRequestAd = tryRequestAd++;
            if (adsType == 3 || adsType == 4 || adsType == 5) {
              updateStateInterstitial(0);
              updateAdNetworkToShow(4);
              loadInterstitial();
            }
          }
        },
      );

  initTimer() {
    debugPrint("initTimer : ${timer?.isActive} before");
    timer?.cancel();
    debugPrint("initTimer : ${timer?.isActive} after");
    timer = null;
    timer = Timer.periodic(Duration(seconds: timeToShow), (Timer t) {
      if (adsType != 0) {
        debugPrint(
            "Rodou AdsController(); adInterstitialState: $adInterstitialState");
        updateShowInterstitialTimer(true);
        if (adInterstitialState == 0) {
          debugPrint(
              "entrou no false AdsController(); showInterstitialTimer: $showInterstitialTimer");
          loadInterstitial();
        }
      }
    });

    debugPrint("initTimer : ${timer?.isActive} finish");
  }

  initBannerAdmob() {
    if (showInterstitialTimer && adsType == 1)
      admobBanner = createBannerAdmob()
        ..load()
        ..show();
  }

  _AdsControllerBase() {
    if (adsType == 2 || adsType == 3 || adsType == 4 || adsType == 5) {
      _initFacebook();
      facebookBanner = createBannerFace();
    }
    initTimer();

    switch (adsType) {
      case 1:
        _initAdmobDefault();

        defaultNetwork = 3;
        updateAdNetworkToShow(defaultNetwork);
        //updateAdBannerToShow(defaultNetwork);
        break;
      case 2:
        defaultNetwork = 4;
        facebookBanner = createBannerFace();
        updateAdNetworkToShow(defaultNetwork);
        updateAdBannerToShow(defaultNetwork);
        break;
      case 3:
        defaultNetwork = 3;
        updateAdNetworkToShow(defaultNetwork);
        //updateAdBannerToShow(defaultNetwork);
        _initAdmobDefault();
        break;
      case 4:
        defaultNetwork = 4;
        updateAdNetworkToShow(defaultNetwork);
        //updateAdBannerToShow(defaultNetwork);
        _initAdmobDefault();
        break;
      default:
        debugPrint("ads_type: $adsType Ads desativado == 0");
    }

    if (adsType != 0) loadInterstitial();
  }

  _initFacebook() async {
    var initFace = await FacebookAudienceNetwork.init(
        testingId: "36070a49-12d8-40dd-96b3-52ae3c8ada62");
    debugPrint("faceAd started: $initFace");
  }

  _initAdmobDefault() {
    FirebaseAdMob.instance.initialize(appId: admobAppId);
  }

  loadInterstitial() {
    debugPrint("loadInterstitial() tryRequestAd: $tryRequestAd");
    if (tryRequestAd <= 12) {
      switch (adsType) {
        case 1:
          admobInterstitial?.dispose();
          admobInterstitial = interstitialAdAdmob()..load();
          break;
        case 2:
          createInterstitialAdFace();
          break;
        case 3:
          debugPrint("loadInterstitial() switch: 3");
          _logicAdmobDefaultAndFacebook();
          break;
        case 4:
          _logicAdmobDefaultAndFacebook();
          break;
        case 5:
          //_logicAdmobAndFacebook();
          break;
        default:
          debugPrint("ads_type: $adsType ad not loaded and not request");
      }
    }
  }

  showInterstitial() async {
    debugPrint(
        "calling showInterstitial() showInterstitialTimer: $showInterstitialTimer && adInterstitialState: $adInterstitialState");
    switch (adsType) {
      case 1:
        if (admobInterstitial != null &&
            await admobInterstitial.isLoaded() &&
            showInterstitialTimer &&
            adInterstitialState == 1) {
          debugPrint("showInterstitial ==> loadInterstitial if");
          admobInterstitial?.show();
          if (timer?.isActive == true) initTimer();
        } else {
          if (!showInterstitialTimer && adInterstitialState == 0) {
            loadInterstitial();
            debugPrint("showInterstitial ==> loadInterstitial else");
          }
        }
        break;
      case 2:
        // facebookBanner = null;
        // debugPrint("failRequestBannerFace");
        // facebookBanner = createBannerFace();
        if (adInterstitialState == 1 && showInterstitialTimer) {
          debugPrint("face showInterstitial ==> loadInterstitial if");
          FacebookInterstitialAd.showInterstitialAd();
          if (timer?.isActive == true) initTimer();
        } else {
          if (!showInterstitialTimer && adInterstitialState == 0) {
            loadInterstitial();
            debugPrint("face showInterstitial ==> loadInterstitial else");
          }
        }
        break;
      case 3:
        _showAdmobAndFacebookInterstitial();
        break;
      case 4:
        _showAdmobAndFacebookInterstitial();
        break;
      default:
        debugPrint("not showing ad");
    }
  }

  _showAdmobAndFacebookInterstitial() async {
    debugPrint("calling ad_type: $adsType");
    if (adnetworkToShow == 3) {
      debugPrint("calling adnetworkToShow: 3");
      if (admobInterstitial != null &&
          await admobInterstitial.isLoaded() &&
          showInterstitialTimer &&
          adInterstitialState == 1) {
        admobInterstitial?.show();
        if (timer?.isActive == true) initTimer();
      } else {
        debugPrint("showInterstitial ==> loadInterstitial");
        if (!showInterstitialTimer && adInterstitialState == 0) {
          loadInterstitial();
          debugPrint("showInterstitial ==> loadInterstitial else");
        }
      }
    } else {
      debugPrint(
          "calling adnetworkToShow: $adnetworkToShow && adState: $adInterstitialState");
      if (adInterstitialState == 1 && showInterstitialTimer) {
        FacebookInterstitialAd.showInterstitialAd();
        if (timer?.isActive == true) initTimer();
      } else if (!showInterstitialTimer && adInterstitialState == 0) {
        loadInterstitial();
        debugPrint("showInterstitial ==> loadInterstitial else");
      }
    }
  }

  _logicAdmobDefaultAndFacebook() async {
    debugPrint(
        "_logicAdmobDefaultAndFacebook() $adnetworkToShow && failRequestBannerFace: $failRequestBannerFace");
    if (adnetworkToShow == 3) {
      if (!failRequestBannerFace) {
        facebookBanner = null;
        if (primeiraCall == 0)
          primeiraCall++;
        else
          admobBanner = createBannerAdmob()
            ..load()
            ..show();
      }
      admobInterstitial = interstitialAdAdmob()..load();
    } else {
      if (!failRequestBannerFace) {
        updateAdBannerToShow(4);
        admobBanner?.dispose();
        admobBanner = null;
        facebookBanner = null;
        debugPrint("failRequestBannerFace");
        facebookBanner = createBannerFace();
      }

      bool showFace = await createInterstitialAdFace();
      debugPrint(
          "calling _logicAdmobDefaultAndFacebook() else showFace: $showFace");
    }
  }

  Widget showBanner(
          {Widget widgetNavigation,
          double heightNavigation = kBottomNavigationBarHeight}) =>
      Observer(builder: (context) {
        return adBannerToShow != 0
            ? Container(
                height: widgetNavigation != null
                    ? heightNavigation
                    : 0 +
                        (adBannerToShow == 4
                            ? 50
                            : getMargin(MediaQuery.of(context).size.height)),
                child: Column(
                  children: <Widget>[
                    widgetNavigation ??
                        Container(
                          width: 0,
                          height: 0,
                        ),
                    Container(
                      height: adBannerToShow == 4
                          ? 50
                          : getMargin(MediaQuery.of(context).size.height),
                      child: adBannerToShow == 4
                          ? facebookBanner
                          : Container(
                              width: 0,
                              height: 0,
                            ),
                    ),
                  ],
                ),
              )
            : Container(
                height: heightNavigation,
                child: Column(
                  children: <Widget>[
                    widgetNavigation ??
                        Container(
                          width: 0,
                          height: 0,
                        ),
                  ],
                ),
              );
      });

  double getMargin(double height) {
    double margin;

    if (height <= 400) {
      margin = 37;
    } else if (height >= 400 && height < 720) {
      margin = 55;
    } else if (height >= 720) {
      margin = 95;
    }
    return margin;
  }

  @override
  void dispose() {
    admobBanner?.dispose();
    timer?.cancel();
    admobInterstitial.dispose();
  }
}
