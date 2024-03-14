import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:filmflex_movie_application/widgets/no_internet_overlay.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxBool isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initConnectivityCheck();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivityCheck() async {
    await _checkInternetConnection();
  }

  void _updateConnectionStatus(ConnectivityResult result) async {
    await _checkInternetConnection();
  }

  
  Future<void> _checkInternetConnection() async {
    bool previousState = isConnected.value;
    var result = await _connectivity.checkConnectivity();
    bool currentStatus = result != ConnectivityResult.none && await isInternetConnected();
    isConnected.value = currentStatus;

    
    if (previousState != isConnected.value) {
      manageConnectivityOverlay(currentStatus);
    }
  }

  Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void manageConnectivityOverlay(bool isConnected) {
    if (!isConnected) {
      
      if (!(Get.isDialogOpen ?? false)) {
        Get.dialog(
          const NoInternetOverlay(),
          barrierDismissible: false, 
        );
      }
    } else {
      
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    }
  }

  Future<void> checkInitialConnectivity() async {
    await _checkInternetConnection(); 
  }
}
