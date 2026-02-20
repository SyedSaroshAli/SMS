import 'package:get/get.dart';
import 'package:school_management_system/models/noticesModel.dart';
 

class NoticesController extends GetxController {
  var notices = <NoticeModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNoticesApi();
  }

  Future<void> fetchNoticesApi() async {
    isLoading.value = true;

    // simulate API delay
    await Future.delayed(Duration(seconds: 1));

    // simulate API data (replace with actual API later)
    List<NoticeModel> apiData = [
      NoticeModel(title: "Annual Sports Day", description: "Annual sports day will be held on 20th March in school ground.", date: DateTime.now()),
      NoticeModel(title: "Holiday Announcement", description: "School will remain closed on 15th Feb due to public holiday.", date: DateTime.now().subtract(Duration(days: 1))),
      NoticeModel(title: "Parent-Teacher Meeting", description: "PTM scheduled for 10th March in the auditorium.", date: DateTime.now().subtract(Duration(days: 2))),
      NoticeModel(title: "Library Notice", description: "New books have arrived in the library, check them out!", date: DateTime.now().subtract(Duration(days: 3))),
      NoticeModel(title: "Exam Schedule", description: "Midterm exams start from 25th Feb.", date: DateTime.now().subtract(Duration(days: 4))),
      NoticeModel(title: "Science Fair", description: "Annual Science Fair will be held on 28th Feb.", date: DateTime.now().subtract(Duration(days: 5))),
      NoticeModel(title: "Art Competition", description: "Art competition submission ends on 22nd Feb.", date: DateTime.now().subtract(Duration(days: 6))),
    ];

    // sort descending by date (latest first)
    apiData.sort((a, b) => b.date.compareTo(a.date));

    // mark top 5 as new
    for (int i = 0; i < apiData.length; i++) {
      apiData[i].isNew = i < 5;
    }

    notices.value = apiData;
    isLoading.value = false;
  }

  Future<void> refreshNotices() async {
    await fetchNoticesApi();
  }
}
