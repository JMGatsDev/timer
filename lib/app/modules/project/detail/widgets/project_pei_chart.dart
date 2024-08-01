import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProjectPeiChart extends StatelessWidget {
  const ProjectPeiChart(
      {super.key, required this.projectEstimate, required this.totalTask});

  final int projectEstimate;
  final int totalTask;
  @override
  Widget build(BuildContext context) {
    final residual = (projectEstimate - totalTask);
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.25,
      height: screenSize.height * 0.25,
      child: Stack(
        fit: StackFit.loose,
        children: [
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: totalTask.toDouble(),
                  color: theme.primaryColorLight,
                  showTitle: true,
                  title: '${totalTask}h',
                  titleStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                PieChartSectionData(
                  value: residual.toDouble(),
                  color: theme.primaryColor,
                  showTitle: true,
                  title: '${residual}h',
                  titleStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${projectEstimate}h',
              style: TextStyle(
                  fontSize: 25,
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
