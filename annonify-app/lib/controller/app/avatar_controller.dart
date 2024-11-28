import 'package:annonify/models/avatar.dart';
import 'package:annonify/repositories/avatar_repo.dart';
import 'package:get/get.dart';

class AvatarController extends GetxController {
  final AvatarRepository avatarRepository;

  // Observable list of avatars
  final avatars = <Avatar>[].obs;

  final RxString selectedAvatar = "".obs;

  AvatarController(this.avatarRepository);

  @override
  void onInit() {
    super.onInit();
    if (avatars.isEmpty) {
      fetchAvatars();
    }
  }

  void selectAvatar(String name) {
    selectedAvatar.value = name;
  }

  Future<void> fetchAvatars() async {
    try {
      await avatarRepository.fetchAndCacheAvatars();
      avatars.value = avatarRepository.getAllAvatars();
    } catch (e) {
      print("Error fetching avatars: $e");
    }
  }

  Avatar? getAvatarByName(String name) {
    try {
      int index = avatars.indexWhere((element) => element.name == name);
      if (index != -1) {
        return avatars[index];
      } else {
        print("Avatar with name '$name' not found. Returning null.");
        return null; // Safely return null if the name is not found
      }
    } catch (e) {
      print("Error in getAvatarByName: $e");
      return null; // Return null to avoid unhandled exceptions
    }
  }
}
