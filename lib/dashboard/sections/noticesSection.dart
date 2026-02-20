import 'package:flutter/material.dart';

class NoticesSection extends StatelessWidget {
  const NoticesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample notices data
    final List<Map<String, dynamic>> notices = [
      {
        'title': 'Midterm Exams Start',
        'date': 'Feb 15th',
        'icon': Icons.event_note,
        'color': Colors.red,
      },
      {
        'title': 'Fee Reminder',
        'date': 'Feb 20th',
        'icon': Icons.payment,
        'color': Colors.orange,
      },
      {
        'title': 'Sports Day Event',
        'date': 'Feb 25th',
        'icon': Icons.sports_soccer,
        'color': Colors.blue,
      },
      {
        'title': 'Parent Meeting',
        'date': 'Mar 1st',
        'icon': Icons.people,
        'color': Colors.green,
      },
      {
        'title': 'Holiday Notice',
        'date': 'Mar 5th',
        'icon': Icons.celebration,
        'color': Colors.purple,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notices',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all notices
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Horizontal Scrollable Notices
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: notices.length,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            itemBuilder: (context, index) {
              final notice = notices[index];
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Icon with colored background
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: notice['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          notice['icon'],
                          color: notice['color'],
                          size: 24,
                        ),
                      ),
                      
                      const SizedBox(width: 12),
                      
                      // Notice text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              notice['title'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notice['date'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}