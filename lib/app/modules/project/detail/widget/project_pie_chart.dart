import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectPieChart extends StatelessWidget {
  final double projectEstimate;
  final double totalTask;

  const ProjectPieChart(
      {Key? key, required this.projectEstimate, required this.totalTask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double residual = (projectEstimate - totalTask);

    final theme = Theme.of(context);
    return SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          fit: StackFit.loose,
          children: [
            PieChart(PieChartData(
              sections: [
                //Total de horas já gastos
                PieChartSectionData(
                  value: totalTask.toDouble(),
                  color: theme.primaryColor,
                  showTitle: true,
                  title: '${totalTask.toStringAsFixed(0)}h',
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  //Total de horas restantes
                  value: residual.toDouble(),
                  color: theme.primaryColorLight,
                  showTitle: true,
                  title: '${residual.toStringAsFixed(0)}h',
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
            Align(
              //Total
              alignment: Alignment.center,
              child: Text(
                '${projectEstimate.toStringAsFixed(0)}h',
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
