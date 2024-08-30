

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class ProgressScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Progress'),
//         backgroundColor: Colors.teal.shade700, // Updated AppBar color
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'My Progress Over Time',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.teal.shade700,
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: LineChartWidget(),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.teal.shade50, // Soft background color
//     );
//   }
// }

// class LineChartWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         gridData: FlGridData(
//           show: true, // Display grid lines
//           getDrawingHorizontalLine: (value) {
//             return FlLine(
//               color: Colors.teal.shade100,
//               strokeWidth: 1,
//             );
//           },
//           getDrawingVerticalLine: (value) {
//             return FlLine(
//               color: Colors.teal.shade100,
//               strokeWidth: 1,
//             );
//           },
//         ),
//         titlesData: FlTitlesData(
//           bottomTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 22,
//             getTextStyles: (context, value) => const TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//             margin: 8,
//             getTitles: (value) {
//               switch (value.toInt()) {
//                 case 0:
//                   return 'Mon';
//                 case 1:
//                   return 'Tue';
//                 case 2:
//                   return 'Wed';
//                 case 3:
//                   return 'Thu';
//                 case 4:
//                   return 'Fri';
//               }
//               return '';
//             },
//           ),
//           leftTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 32,
//             getTextStyles: (context, value) => const TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             ),
//             margin: 12,
//           ),
//         ),
//         borderData: FlBorderData(
//           show: true,
//           border: Border.all(
//             color: Colors.teal.shade200,
//             width: 2,
//           ),
//         ),
//         lineBarsData: [
//           LineChartBarData(
//             spots: [
//               FlSpot(0, 1),
//               FlSpot(1, 2),
//               FlSpot(2, 1.5),
//               FlSpot(3, 3),
//               FlSpot(4, 2.5),
//             ],
//             isCurved: true, // Enable curves for smoother lines
//             colors: [Colors.teal.shade200, Colors.teal.shade700],
//             dotData: FlDotData(show: true), // Show dots on data points
//             belowBarData: BarAreaData(
//               show: true,
//               colors: [Colors.teal.withOpacity(0.3)],
//             ),
//           ),
//         ],
//         lineTouchData: LineTouchData(
//           touchTooltipData: LineTouchTooltipData(
//             tooltipBgColor: Colors.teal.shade700,
//             getTooltipItems: (touchedSpots) {
//               return touchedSpots.map((spot) {
//                 return LineTooltipItem(
//                   '${spot.x}, ${spot.y}',
//                   TextStyle(color: Colors.white),
//                 );
//               }).toList();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class ProgressScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Progress'),
//         backgroundColor: Colors.teal.shade700, // Updated AppBar color
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'My Progress Over Time',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.teal.shade700,
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: LineChartWidget(),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.teal.shade50, // Soft background color
//     );
//   }
// }

// class LineChartWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         gridData: FlGridData(
//           show: true, // Display grid lines
//           drawVerticalLine: true, // Ensure vertical grid lines are drawn
//           drawHorizontalLine: true, // Ensure horizontal grid lines are drawn
//           getDrawingHorizontalLine: (value) {
//             return FlLine(
//               color: Colors.teal.shade100,
//               strokeWidth: 1,
//             );
//           },
//           getDrawingVerticalLine: (value) {
//             return FlLine(
//               color: Colors.teal.shade100,
//               strokeWidth: 1,
//             );
//           },
//         ),
//         titlesData: FlTitlesData(
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 40,
//               titleWidget: (value, meta) {
//                 final text = Text(
//                   _getBottomTitle(value.toInt()),
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 );
//                 return SideTitleWidget(
//                   axisSide: meta.axisSide,
//                   child: text,
//                 );
//               },
//               padding: EdgeInsets.only(bottom: 8),
//             ),
//           ),
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 40,
//               titleWidget: (value, meta) {
//                 final text = Text(
//                   value.toString(),
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 );
//                 return SideTitleWidget(
//                   axisSide: meta.axisSide,
//                   child: text,
//                 );
//               },
//               padding: EdgeInsets.only(left: 12),
//             ),
//           ),
//         ),
//         borderData: FlBorderData(
//           show: true,
//           border: Border.all(
//             color: Colors.teal.shade200,
//             width: 2,
//           ),
//         ),
//         lineBarsData: [
//           LineChartBarData(
//             spots: [
//               FlSpot(0, 1),
//               FlSpot(1, 2),
//               FlSpot(2, 1.5),
//               FlSpot(3, 3),
//               FlSpot(4, 2.5),
//             ],
//             isCurved: true, // Enable curves for smoother lines
//             color: Colors.teal.shade700, // Line color
//             dotData: FlDotData(show: true), // Show dots on data points
//             belowBarData: BarAreaData(
//               show: true,
//               color: Colors.teal.withOpacity(0.3), // Color below the line
//             ),
//           ),
//         ],
//         lineTouchData: LineTouchData(
//           touchTooltipData: LineTouchTooltipData(
//             // Use the background color for the tooltip
//            : Colors.teal.shade700,
//             getTooltipItems: (touchedSpots) {
//               return touchedSpots.map((spot) {
//                 return LineTooltipItem(
//                   '${spot.x.toInt()} ${spot.y.toStringAsFixed(1)}',
//                   TextStyle(color: Colors.white),
//                 );
//               }).toList();
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   String _getBottomTitle(int value) {
//     switch (value) {
//       case 0:
//         return 'Mon';
//       case 1:
//         return 'Tue';
//       case 2:
//         return 'Wed';
//       case 3:
//         return 'Thu';
//       case 4:
//         return 'Fri';
//       default:
//         return '';
//     }
//   }
// }

