import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

// Data Models - ADD THIS AT THE TOP
class StudentExeatSummary {
  final String id;
  final String name;
  final String className;
  final int totalDays;
  final int totalExeats;
  final String lastExeatDate;
  final String? profileImage;
  final String status;
  final String department;

  StudentExeatSummary({
    required this.id,
    required this.name,
    required this.className,
    required this.totalDays,
    required this.totalExeats,
    required this.lastExeatDate,
    this.profileImage,
    required this.status,
    required this.department,
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
  String sortBy = 'Name';
  bool _isSearching = false;

  final TextEditingController _searchController = TextEditingController();

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
      status: 'Active',
      department: 'Software engineering',
    ),
    StudentExeatSummary(
      id: '2',
      name: 'Ilesanmi Daniel',
      className: '400l',
      totalDays: 23,
      totalExeats: 12,
      lastExeatDate: '2 days ago',
      profileImage: null,
      status: 'Active',
      department: 'Software Engineering',
    ),
    StudentExeatSummary(
      id: '3',
      name: 'Olufemi Maverlous',
      className: '200l',
      totalDays: 8,
      totalExeats: 5,
      lastExeatDate: '1 week ago',
      profileImage: null,
      status: 'Active',
      department: 'Accounting',
    ),
    StudentExeatSummary(
      id: '4',
      name: 'Macfoy Victor',
      className: '400l',
      totalDays: 19,
      totalExeats: 10,
      lastExeatDate: '3 days ago',
      profileImage: null,
      status: 'Inactive',
      department: 'Software Engineering',
    ),
    StudentExeatSummary(
      id: '5',
      name: 'David Ajayi',
      className: '100l',
      totalDays: 12,
      totalExeats: 7,
      lastExeatDate: '1 day ago',
      profileImage: null,
      status: 'Active',
      department: 'microbiology',
    ),
    StudentExeatSummary(
      id: '6',
      name: 'Grace Johnson',
      className: '300l',
      totalDays: 21,
      totalExeats: 11,
      lastExeatDate: '4 days ago',
      profileImage: null,
      status: 'Active',
      department: 'criminology',
    ),
  ];

  List<StudentExeatSummary> get filteredStudents {
    List<StudentExeatSummary> filtered = students.where((student) {
      final matchesSearch = student.name
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          student.className.toLowerCase().contains(searchQuery.toLowerCase()) ||
          student.department.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesFilter = filterBy == 'All' ||
          (filterBy == 'Active' && student.status == 'Active') ||
          (filterBy == 'Inactive' && student.status == 'Inactive') ||
          student.className == filterBy;

      return matchesSearch && matchesFilter;
    }).toList();

    // Apply sorting
    filtered.sort((a, b) {
      switch (sortBy) {
        case 'Name':
          return a.name.compareTo(b.name);
        case 'Days (High to Low)':
          return b.totalDays.compareTo(a.totalDays);
        case 'Days (Low to High)':
          return a.totalDays.compareTo(b.totalDays);
        case 'Exeats (High to Low)':
          return b.totalExeats.compareTo(a.totalExeats);
        case 'Class':
          return a.className.compareTo(b.className);
        default:
          return a.name.compareTo(b.name);
      }
    });

    return filtered;
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildFilterSheet(),
    );
  }

  Widget _buildFilterSheet() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter & Sort',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff060121),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Filter Section
            const Text(
              'Filter by Status',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: ['All', 'Active', 'Inactive'].map((status) {
                return FilterChip(
                  label: Text(status),
                  selected: filterBy == status,
                  onSelected: (selected) {
                    setState(() {
                      filterBy = selected ? status : 'All';
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Sort Section
            const Text(
              'Sort by',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...[
              'Name',
              'Days (High to Low)',
              'Days (Low to High)',
              'Exeats (High to Low)',
              'Class'
            ].map((option) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Radio<String>(
                  value: option,
                  groupValue: sortBy,
                  onChanged: (value) {
                    setState(() {
                      sortBy = value!;
                    });
                    Navigator.pop(context);
                  },
                ),
                title: Text(option),
                onTap: () {
                  setState(() {
                    sortBy = option;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalDays = students.fold(0, (sum, s) => sum + s.totalDays);
    final totalExeats = students.fold(0, (sum, s) => sum + s.totalExeats);
    final avgDays = totalDays / students.length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search students...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              )
            : const Text(
                'Student Exeat Analytics',
                style: TextStyle(color: Colors.white),
              ),
        backgroundColor: const Color(0xff060121),
        elevation: 0,
        actions: [
          if (_isSearching)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  searchQuery = '';
                  _searchController.clear();
                });
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
            ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilters(context),
            tooltip: 'Filter & Sort',
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Get.to(() => const OverallAnalyticsDashboard());
            },
            tooltip: 'Overall Analytics',
          ),
        ],
      ),
      body: Column(
        children: [
          // Enhanced Summary Stats
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xff060121),
                  const Color(0xff1a0f3e),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildEnhancedStat(
                    'Total Students',
                    '${students.length}',
                    Icons.people_outline,
                    Colors.blue.shade300,
                  ),
                ),
                Container(
                    width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
                Expanded(
                  child: _buildEnhancedStat(
                    'Total Days',
                    totalDays.toString(),
                    Icons.calendar_today,
                    Colors.green.shade300,
                  ),
                ),
                Container(
                    width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
                Expanded(
                  child: _buildEnhancedStat(
                    'Total Exeats',
                    totalExeats.toString(),
                    Icons.logout,
                    Colors.orange.shade300,
                  ),
                ),
                Container(
                    width: 1, height: 40, color: Colors.white.withOpacity(0.3)),
                Expanded(
                  child: _buildEnhancedStat(
                    'Avg Days',
                    avgDays.toStringAsFixed(1),
                    Icons.trending_up,
                    Colors.purple.shade300,
                  ),
                ),
              ],
            ),
          ),

          // Quick Filters
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickFilter('All', 'All'),
                  _buildQuickFilter('Active', 'Active'),
                  _buildQuickFilter('Inactive', 'Inactive'),
                  _buildQuickFilter('400L', '400l'),
                  _buildQuickFilter('300L', '300l'),
                  _buildQuickFilter('200L', '200l'),
                  _buildQuickFilter('100L', '100l'),
                ],
              ),
            ),
          ),

          // Students List Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Students (${filteredStudents.length})',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff060121),
                  ),
                ),
                Text(
                  'Sorted by: $sortBy',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Students List
          Expanded(
            child: filteredStudents.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      return _buildStudentCard(filteredStudents[index], index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(String label, String value) {
    final isSelected = filterBy == value;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            filterBy = selected ? value : 'All';
          });
        },
        backgroundColor: Colors.grey[100],
        selectedColor: const Color(0xff060121),
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildEnhancedStat(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStudentCard(StudentExeatSummary student, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
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
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Profile Picture with Status
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.indigo[100],
                        child: student.profileImage != null
                            ? ClipOval(
                                child: Image.network(student.profileImage!,
                                    fit: BoxFit.cover))
                            : Text(
                                student.name
                                    .split(' ')
                                    .map((n) => n[0])
                                    .take(2)
                                    .join(),
                                style: TextStyle(
                                  color: Colors.indigo[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: student.status == 'Active'
                                ? Colors.green
                                : Colors.grey,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),

                  // Student Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                student.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.indigo[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                student.className,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          student.department,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
                      _buildStatBadge('${student.totalDays} days',
                          Icons.calendar_today, Colors.blue),
                      const SizedBox(height: 6),
                      _buildStatBadge('${student.totalExeats} exeats',
                          Icons.logout, Colors.green),
                    ],
                  ),

                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right, color: Colors.grey[400]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatBadge(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            searchQuery.isEmpty ? 'No students available' : 'No students found',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff060121)),
          ),
          const SizedBox(height: 8),
          Text(
            searchQuery.isEmpty
                ? 'Add students to see analytics'
                : 'Try adjusting your search or filters',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          if (searchQuery.isNotEmpty) ...[
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  searchQuery = '';
                  _searchController.clear();
                });
              },
              icon: const Icon(Icons.clear_all),
              label: const Text('Clear Search'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff060121),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Add this new Overall Analytics Dashboard
class OverallAnalyticsDashboard extends StatelessWidget {
  const OverallAnalyticsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overall Analytics'),
        backgroundColor: const Color(0xff060121),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Overall Analytics Dashboard - Coming Soon!'),
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
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff060121),
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
                      gridData:
                          const FlGridData(show: true, drawVerticalLine: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
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
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(
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
                          dotData: const FlDotData(show: true),
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
                      gridData:
                          const FlGridData(show: true, drawVerticalLine: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
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
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(
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
