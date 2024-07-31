import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProjectPeiChart extends StatelessWidget {
  const ProjectPeiChart({super.key});

  @override
  Widget build(BuildContext context) {
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
                  value: 50,
                  color: theme.primaryColor,
                  showTitle: true,
                  title: '50h',
                  titleStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                PieChartSectionData(
                    value: 150,
                    color: theme.primaryColorLight,
                    showTitle: true,
                    title: '150h',
                    titleStyle: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '200 H',
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
