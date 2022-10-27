import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user_model.dart';

class SearchController extends GetxController {
  final Rx<List<UserModel>> _searchedUser = Rx<List<UserModel>>([]);
  List<UserModel> get searchedUser => _searchedUser.value;

  userSearch(String typeUser) async {
    _searchedUser.bindStream(
      firestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: typeUser)
          .snapshots()
          .map(
        (QuerySnapshot querySnapshot) {
          List<UserModel> returnUser = [];
          for (var user in querySnapshot.docs) {
            returnUser.add(
              UserModel.fromJson(user),
            );
          }
          return returnUser;
        },
      ),
    );
  }
}
