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

  Avatar getAvatarByName(String name) {
    int index = avatars.indexWhere((element) => element.name == name);
    return avatars[index];
  }
}
