import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:user_hub/services/apiServices.dart';
import '../model/get_user_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<GetUserDetails> getUserData = <GetUserDetails>[].obs;
  RxList<GetUserDetails> searchData = <GetUserDetails>[].obs;
  var kLogger = Logger();

  RxString searchResult = " ".obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading(true);
      final apiResponse = await ApiServices().getData(api: "/users");

      kLogger.d("API Response of getUserDetails : $apiResponse");

      if (apiResponse is List) {
        final userList =
            apiResponse.map((e) => GetUserDetails.fromMap(e)).toList();
        getUserData.assignAll(userList);
        searchData.assignAll(userList);
      } else {
        Get.snackbar("Failed", "Failed to fetch Users");
      }
    } catch (e) {
      kLogger.e(e);
    } finally {
      isLoading(false);
    }
  }

  void filterUsers({required String userName}) {
    if (userName.isEmpty) {
      searchData.assignAll(getUserData);
    } else {
      searchData.assignAll(getUserData.where((user) =>
          user.username?.toLowerCase().contains(userName.toLowerCase()) ??
          false));
    }
  }
}
