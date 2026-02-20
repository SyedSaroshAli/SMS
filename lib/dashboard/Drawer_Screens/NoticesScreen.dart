import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_management_system/controllers/noticeController.dart';
import 'package:school_management_system/models/noticesModel.dart';


class NoticesScreen extends StatelessWidget {
  NoticesScreen({super.key});

  // GetX controller instance (must be initialized in main.dart with Get.put)
  final noticeController = Get.find<NoticesController>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Notices"),
          centerTitle: true,
         
        ),
        body: Obx(() {
          // 1️⃣ Loading state
          if (noticeController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2️⃣ Empty state
          if (noticeController.notices.isEmpty) {
            return Center(
              child: Text(
                "No notices yet",
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black54,
                  fontSize: 16,
                ),
              ),
            );
          }

          // 3️⃣ List of notices with pull-to-refresh
          return RefreshIndicator(
            onRefresh: noticeController.refreshNotices,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: noticeController.notices.length,
              itemBuilder: (context, index) {
                final notice = noticeController.notices[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  color: isDark ? Colors.grey[850] : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title + NEW badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                notice.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                            if (notice.isNew == true)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "NEW",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Description
                        Text(
                          notice.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[300] : Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Date
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "${notice.date.day.toString().padLeft(2, '0')}-"
                            "${notice.date.month.toString().padLeft(2, '0')}-"
                            "${notice.date.year}",
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
