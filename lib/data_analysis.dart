import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Main screen with list of students
class StudentsExeatListScreen extends StatefulWidget {
  const StudentsExeatListScreen({super.key});

  @override
  State<StudentsExeatListScreen> createState() =>
      _StudentsExeatListScreenState();
}

class _StudentsExeatListScreenState extends State<StudentsExeatListScreen> {
  String searchQuery = '';
  String filterBy = 'All';

  // Sample data - replace with your actual data from database
  final List<StudentExeatSummary> students = [
    StudentExeatSummary(
      id: '1',
      name: 'Fred Daniel',
      className: '400l',
      totalDays: 15,
      totalExeats: 8,
      lastExeatDate: '5 days ago',
      profileImage: null,
    ),
    StudentExeatSummary(
      id: '2',
      name: 'Ilesanmi Daniel',
      className: '400l',
      totalDays: 23,
      totalExeats: 12,
      lastExeatDate: '2 days ago',
      profileImage: null,
    ),
    StudentExeatSummary(
      id: '3',
      name: 'Olufemi Maverlous',
      className: '200l',
      totalDays: 8,
      totalExeats: 5,
      lastExeatDate: '1 week ago',
      profileImage: null,
    ),
    StudentExeatSummary(
      id: '4',
      name: 'Macfoy Victor',
      className: '400l',
      totalDays: 19,
      totalExeats: 10,
      lastExeatDate: '3 days ago',
      profileImage: null,
    ),
    StudentExeatSummary(
      id: '5',
      name: 'David Ajayi',
      className: '100l',
      totalDays: 12,
      totalExeats: 7,
      lastExeatDate: '1 day ago',
      profileImage: null,
    ),
  ];

  List<StudentExeatSummary> get filteredStudents {
    return students.where((student) {
      final matchesSearch = student.name
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          student.className.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Student Exeat Analytics',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff060121),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Summary Stats
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildQuickStat('Total Students', '${students.length}',
                      Icons.people, Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickStat(
                      'Avg Days', '15.4', Icons.calendar_today, Colors.green),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickStat(
                      'Total Exeats',
                      '${students.fold(0, (sum, s) => sum + s.totalExeats)}',
                      Icons.logout,
                      Colors.orange),
                ),
              ],
            ),
          ),

          // Students List
          Expanded(
            child: filteredStudents.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,
                            size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No students found',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      return _buildStudentCard(filteredStudents[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = filterBy == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            filterBy = label;
          });
        },
        backgroundColor: Colors.white.withOpacity(0.2),
        selectedColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.indigo : Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildQuickStat(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStudentCard(StudentExeatSummary student) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentDetailAnalyticsScreen(
              studentId: student.id,
              studentName: student.name,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.indigo[100],
                child: student.profileImage != null
                    ? ClipOval(
                        child: Image.network(student.profileImage!,
                            fit: BoxFit.cover))
                    : Text(
                        student.name.split(' ').map((n) => n[0]).take(2).join(),
                        style: TextStyle(
                          color: Colors.indigo[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
              ),
              const SizedBox(width: 16),

              // Student Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      student.className,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          student.lastExeatDate,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today,
                            size: 14, color: Colors.blue[700]),
                        const SizedBox(width: 4),
                        Text(
                          '${student.totalDays} days',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.logout, size: 14, color: Colors.green[700]),
                        const SizedBox(width: 4),
                        Text(
                          '${student.totalExeats} exeats',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}

// Detail Analytics Screen for Individual Student
class StudentDetailAnalyticsScreen extends StatefulWidget {
  final String studentId;
  final String studentName;

  const StudentDetailAnalyticsScreen({
    super.key,
    required this.studentId,
    required this.studentName,
  });

  @override
  State<StudentDetailAnalyticsScreen> createState() =>
      _StudentDetailAnalyticsScreenState();
}

class _StudentDetailAnalyticsScreenState
    extends State<StudentDetailAnalyticsScreen> {
  String selectedPeriod = 'This Term';

  // Sample data - replace with your actual data from database
  final List<ExeatData> monthlyData = [
    ExeatData('Jan', 2),
    ExeatData('Feb', 3),
    ExeatData('Mar', 1),
    ExeatData('Apr', 4),
    ExeatData('May', 2),
    ExeatData('Jun', 3),
  ];

  final Map<String, int> reasonsData = {
    'Family Visit': 8,
    'Medical': 3,
    'Religious': 2,
    'Emergency': 1,
    'Other': 1,
  };

  final List<RecentExeat> recentExeats = [
    RecentExeat('March 15, 2024', 'Family Visit', 2),
    RecentExeat('March 8, 2024', 'Medical', 1),
    RecentExeat('Feb 28, 2024', 'Family Visit', 3),
    RecentExeat('Feb 14, 2024', 'Religious', 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          '${widget.studentName}\'s Analytics',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff060121),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            color: Colors.white,
            onPressed: () {
              // Share analytics
            },
          ),
          PopupMenuButton<String>(
            initialValue: selectedPeriod,
            onSelected: (value) {
              setState(() {
                selectedPeriod = value;
              });
            },
            itemBuilder: (context) => [
              'This Week',
              'This Month',
              'This Term',
              'This Year',
              'All Time'
            ]
                .map((period) => PopupMenuItem(
                      value: period,
                      child: Text(period),
                    ))
                .toList(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Total Days', '15',
                      Icons.calendar_today, Colors.blue, '+2 this month'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('Total Exeats', '15', Icons.logout,
                      Colors.green, '5 approved'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Avg Days/Exeat', '1.8',
                      Icons.trending_up, Colors.orange, 'Below average'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('Last Exeat', '5d ago', Icons.history,
                      Colors.purple, 'Mar 15, 2024'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Monthly Trend Chart
            _buildChartCard(
              'Monthly Exeat Days Trend',
              SizedBox(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, top: 16),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true, drawVerticalLine: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true, reservedSize: 40, interval: 1),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >= 0 &&
                                  value.toInt() < monthlyData.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(monthlyData[value.toInt()].month,
                                      style: const TextStyle(fontSize: 12)),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: monthlyData
                              .asMap()
                              .entries
                              .map((e) => FlSpot(
                                  e.key.toDouble(), e.value.days.toDouble()))
                              .toList(),
                          isCurved: true,
                          color: Colors.indigo,
                          barWidth: 3,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(
                              show: true,
                              color: Colors.indigo.withOpacity(0.1)),
                        ),
                      ],
                      minY: 0,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Cumulative Chart
            _buildChartCard(
              'Cumulative Days Over Time',
              SizedBox(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, top: 16),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      gridData: FlGridData(show: true, drawVerticalLine: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                interval: 5)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >= 0 &&
                                  value.toInt() < monthlyData.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(monthlyData[value.toInt()].month,
                                      style: const TextStyle(fontSize: 12)),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: monthlyData.asMap().entries.map((e) {
                        int cumulative = monthlyData
                            .sublist(0, e.key + 1)
                            .fold(0, (sum, item) => sum + item.days);
                        return BarChartGroupData(
                          x: e.key,
                          barRods: [
                            BarChartRodData(
                              toY: cumulative.toDouble(),
                              color: Colors.teal,
                              width: 20,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4)),
                            ),
                          ],
                        );
                      }).toList(),
                      minY: 0,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Pie Chart
            _buildChartCard(
              'Exeat Reasons Breakdown',
              SizedBox(
                height: 280,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: PieChart(
                        PieChartData(
                          sections: _generatePieChartSections(),
                          centerSpaceRadius: 50,
                          sectionsSpace: 2,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: reasonsData.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: _getColorForReason(entry.key),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(entry.key,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)),
                                      Text('${entry.value} times',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey[600])),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Recent History
            _buildRecentExeatsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(value,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(title,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(fontSize: 10, color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          chart,
        ],
      ),
    );
  }

  Widget _buildRecentExeatsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Exeat History',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),
          const SizedBox(height: 12),
          ...recentExeats.map((exeat) => _buildExeatHistoryItem(exeat)),
        ],
      ),
    );
  }

  Widget _buildExeatHistoryItem(RecentExeat exeat) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getColorForReason(exeat.reason).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(_getIconForReason(exeat.reason),
                color: _getColorForReason(exeat.reason), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exeat.reason,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 2),
                Text(exeat.date,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12)),
            child: Text('${exeat.days} ${exeat.days == 1 ? 'day' : 'days'}',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[700])),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _generatePieChartSections() {
    final total = reasonsData.values.reduce((a, b) => a + b);
    return reasonsData.entries.map((entry) {
      final percentage = (entry.value / total * 100).toStringAsFixed(1);
      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: '$percentage%',
        color: _getColorForReason(entry.key),
        radius: 60,
        titleStyle: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }

  Color _getColorForReason(String reason) {
    final colors = {
      'Family Visit': Colors.blue,
      'Medical': Colors.red,
      'Religious': Colors.purple,
      'Emergency': Colors.orange,
      'Other': Colors.grey,
    };
    return colors[reason] ?? Colors.grey;
  }

  IconData _getIconForReason(String reason) {
    final icons = {
      'Family Visit': Icons.family_restroom,
      'Medical': Icons.medical_services,
      'Religious': Icons.church,
      'Emergency': Icons.warning_amber,
      'Other': Icons.help_outline,
    };
    return icons[reason] ?? Icons.help_outline;
  }
}

// Data Models
class StudentExeatSummary {
  final String id;
  final String name;
  final String className;
  final int totalDays;
  final int totalExeats;
  final String lastExeatDate;
  final String? profileImage;

  StudentExeatSummary({
    required this.id,
    required this.name,
    required this.className,
    required this.totalDays,
    required this.totalExeats,
    required this.lastExeatDate,
    this.profileImage,
  });
}

class ExeatData {
  final String month;
  final int days;
  ExeatData(this.month, this.days);
}

class RecentExeat {
  final String date;
  final String reason;
  final int days;
  RecentExeat(this.date, this.reason, this.days);
}
