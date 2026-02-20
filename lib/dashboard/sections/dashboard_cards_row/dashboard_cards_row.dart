import 'package:flutter/material.dart';
import 'academic_progress_card.dart';
import 'attendance_pie_chart_card.dart';
import 'next_fee_due_card.dart';

class DashboardCardsRow extends StatelessWidget {
  const DashboardCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // On mobile (< 600px), stack cards vertically
        if (constraints.maxWidth < 600) {
          return Column(
            children: const [
              AcademicProgressCard(
                percentage: 82,
                examName: 'Midterm Exams',
                subtitle: 'Overall Performance',
              ),
              SizedBox(height: 16),
              AttendancePieChartCard(
                present: 18,
                absent: 3,
                leave: 2,
              ),
              SizedBox(height: 16),
              NextFeeDueCard(
                dueDate: '15 March 2026',
                feeType: 'Semester Fee',
                status: 'Due Soon',
              ),
            ],
          );
        }

        // Tablet: 2 columns
        if (constraints.maxWidth < 900) {
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: (constraints.maxWidth - 16) / 2,
                child: const AcademicProgressCard(
                  percentage: 82,
                  examName: 'Midterm Exams',
                  subtitle: 'Overall Performance',
                ),
              ),
              SizedBox(
                width: (constraints.maxWidth - 16) / 2,
                child: const AttendancePieChartCard(
                  present: 18,
                  absent: 3,
                  leave: 2,
                ),
              ),
              SizedBox(
                width: (constraints.maxWidth - 16) / 2,
                child: const NextFeeDueCard(
                  dueDate: '15 March 2026',
                  feeType: 'Semester Fee',
                  status: 'Due Soon',
                ),
              ),
            ],
          );
        }

        // Desktop: 3 columns (side by side) with equal heights
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Expanded(
                child: AcademicProgressCard(
                  percentage: 82,
                  examName: 'Midterm Exams',
                  subtitle: 'Overall Performance',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: AttendancePieChartCard(
                  present: 18,
                  absent: 3,
                  leave: 2,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: NextFeeDueCard(
                  dueDate: '15 March 2026',
                  feeType: 'Monthly Fee',
                  status: 'Due Soon',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}