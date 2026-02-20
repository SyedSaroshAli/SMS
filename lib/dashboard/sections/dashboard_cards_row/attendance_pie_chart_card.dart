import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AttendancePieChartCard extends StatelessWidget {
  final int present;
  final int absent;
  final int leave;

  const AttendancePieChartCard({
    super.key,
    required this.present,
    required this.absent,
    required this.leave,
  });

  @override
  Widget build(BuildContext context) {
    final total = present + absent + leave;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title with icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.pie_chart,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Attendance Overview',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Pie Chart and Legend side by side
          Row(
            children: [
              // Pie Chart with center text
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: 140,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 3,
                          centerSpaceRadius: 35,
                          sections: [
                            PieChartSectionData(
                              value: present.toDouble(),
                              title: '',
                              color: Colors.green.shade400,
                              radius: 45,
                            ),
                            PieChartSectionData(
                              value: absent.toDouble(),
                              title: '',
                              color: Colors.red.shade400,
                              radius: 45,
                            ),
                            PieChartSectionData(
                              value: leave.toDouble(),
                              title: '',
                              color: Colors.orange.shade400,
                              radius: 45,
                            ),
                          ],
                        ),
                      ),
                      // Center total
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$total',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'Days',
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(width: 20),
              
              // Legend beside pie chart
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCompactLegendItem(
                      context, 
                      'Present', 
                      Colors.green.shade400, 
                      present, 
                      total, 
                      Icons.check_circle,
                    ),
                    const SizedBox(height: 14),
                    _buildCompactLegendItem(
                      context, 
                      'Absent', 
                      Colors.red.shade400, 
                      absent, 
                      total, 
                      Icons.cancel,
                    ),
                    const SizedBox(height: 14),
                    _buildCompactLegendItem(
                      context, 
                      'Leave', 
                      Colors.orange.shade400, 
                      leave, 
                      total, 
                      Icons.event_busy,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactLegendItem(
    BuildContext context, 
    String label, 
    Color color, 
    int value, 
    int total, 
    IconData icon,
  ) {
    final percentage = total > 0 ? ((value / total) * 100).toStringAsFixed(0) : '0';
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$value',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: color.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}