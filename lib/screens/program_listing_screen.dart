import 'package:flutter/material.dart';
import '../models/program.dart';

class ProgramListingScreen extends StatefulWidget {
  final bool showAppBar;

  const ProgramListingScreen({super.key, this.showAppBar = false});

  @override
  State<ProgramListingScreen> createState() => _ProgramListingScreenState();
}

class _ProgramListingScreenState extends State<ProgramListingScreen> {
  List<Program> _allPrograms = [];
  List<Program> _filteredPrograms = [];
  bool _isLoading = true;
  String? _error;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
    _searchController.addListener(_filterPrograms);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await Program.fetchPrograms();
      if (!mounted) return;
      setState(() {
        _allPrograms = data;
        _filteredPrograms = data;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load programs. Please try again.';
        _isLoading = false;
      });
    }
  }

  void _filterPrograms() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPrograms = _allPrograms.where((program) {
        return program.title.toLowerCase().contains(query) ||
            program.description.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _openProgramDetails(Program program) {
    Navigator.pushNamed(context, '/program-details', arguments: program);
  }

  Widget _buildBody(BuildContext context) {
    final brandOrange = Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? const Color(0xFF2D3340)
        : const Color(0xFFF1D3BE);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
          child: Row(
            children: const [
              Icon(Icons.auto_awesome_rounded, color: Color(0xFFFB923C)),
              SizedBox(width: 8),
              Text(
                'Excelerate Programs',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFE84D7A),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'search programs',
              prefixIcon: Icon(Icons.search_rounded),
            ),
          ),
        ),
        Expanded(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFFFB923C)),
                )
              : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          size: 60,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _fetchData,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _fetchData,
                  color: brandOrange,
                  child: _filteredPrograms.isEmpty
                      ? ListView(
                          children: const [
                            SizedBox(height: 140),
                            Center(
                              child: Text(
                                'No programs found.',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: _filteredPrograms.length,
                          itemBuilder: (context, index) {
                            final program = _filteredPrograms[index];

                            return Card(
                              color: Theme.of(context).cardColor,
                              margin: const EdgeInsets.only(bottom: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: BorderSide(color: borderColor),
                              ),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      program.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_rounded,
                                          size: 18,
                                          color: brandOrange,
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            'Start Date: ${program.startDate}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      program.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.4,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () =>
                                          _openProgramDetails(program),
                                      child: const Text('View Details'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showAppBar) {
      return Scaffold(
        appBar: AppBar(title: const Text('Program Listing')),
        body: _buildBody(context),
      );
    }

    return SafeArea(child: _buildBody(context));
  }
}
