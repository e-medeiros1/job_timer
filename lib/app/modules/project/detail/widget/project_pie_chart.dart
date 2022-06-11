import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectPieChart extends StatelessWidget {
  const ProjectPieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          fit: StackFit.loose,
          children: [
            PieChart(PieChartData(
              sections: [
                PieChartSectionData(
                  value: 30,
                  color: theme.primaryColor,
                  showTitle: true,
                  title: '30h',
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  value: 70,
                  color: theme.primaryColorLight,
                  showTitle: true,
                  title: '70h',
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
            Align(
              alignment: Alignment.center,
              child: Text(
                '20h',
                style: TextStyle(
                    fontSize: 25,
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}
