import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.teal.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 20),
            _buildStatistics(),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildPieChart(
                      title: 'Assignment Status',
                      sections: _buildAssignmentStatusSections(),
                    ),
                    SizedBox(height: 20),
                    _buildPieChart(
                      title: 'Teacher Workload',
                      sections: _buildTeacherWorkloadSections(),
                    ),
                    SizedBox(height: 20),
                    _buildPieChart(
                      title: 'Course Enrollment',
                      sections: _buildCourseEnrollmentSections(),
                    ),
                    SizedBox(height: 20),
                    _buildPieChart(
                      title: 'Feedback and Ratings',
                      sections: _buildFeedbackRatingsSections(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics() {
    final int totalStudents = 150;
    final int totalTeachers = 20;
    final int totalAssignments = 75;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatisticCard(
          title: 'Total Students',
          value: '$totalStudents',
        ),
        _buildStatisticCard(
          title: 'Total Teachers',
          value: '$totalTeachers',
        ),
        _buildStatisticCard(
          title: 'Total Assignments',
          value: '$totalAssignments',
        ),
      ],
    );
  }

  Widget _buildStatisticCard({required String title, required String value}) {
    return Expanded(
      child: Card(
        color: Colors.teal.shade100,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade300,
                ),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart(
      {required String title, required List<PieChartSectionData> sections}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade300,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: sections,
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _buildAssignmentStatusSections() {
    return [
      PieChartSectionData(
        color: Colors.teal.shade300,
        value: 40,
        title: 'Completed\n40%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: 35,
        title: 'Pending\n35%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 15,
        title: 'Overdue\n15%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 10,
        title: 'Reviewed\n10%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ];
  }

  List<PieChartSectionData> _buildTeacherWorkloadSections() {
    return [
      PieChartSectionData(
        color: Colors.teal.shade300,
        value: 45,
        title: 'Reviewed\n45%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: 30,
        title: 'Pending\n30%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 15,
        title: 'Overdue\n15%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 10,
        title: 'Not Started\n10%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ];
  }

  List<PieChartSectionData> _buildCourseEnrollmentSections() {
    return [
      PieChartSectionData(
        color: Colors.teal.shade300,
        value: 50,
        title: 'Completed\n50%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: 25,
        title: 'Ongoing\n25%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 15,
        title: 'Dropped\n15%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 10,
        title: 'Pending\n10%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ];
  }

  List<PieChartSectionData> _buildFeedbackRatingsSections() {
    return [
      PieChartSectionData(
        color: Colors.teal.shade300,
        value: 60,
        title: 'Positive\n60%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: 25,
        title: 'Neutral\n25%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 10,
        title: 'Negative\n10%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 5,
        title: 'Unrated\n5%',
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ];
  }
}
