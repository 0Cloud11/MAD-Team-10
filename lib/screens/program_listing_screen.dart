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
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = "Failed to load programs. Please check your connection.";
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
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search programs',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(child: _buildListContent(primary)),
      ],
    );
  }

  Widget _buildListContent(Color primary) {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Fetching programs...',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 60,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _fetchData, child: const Text('Retry')),
            ],
          ),
        ),
      );
    }

    if (_filteredPrograms.isEmpty) {
      return const Center(
        child: Text('No programs found.', style: TextStyle(fontSize: 16)),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchData,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _filteredPrograms.length,
        itemBuilder: (context, index) {
          final program = _filteredPrograms[index];
          final isDark = Theme.of(context).brightness == Brightness.dark;

          return Card(
            margin: const EdgeInsets.only(bottom: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF232833)
                      : const Color(0xFFF1D3BE),
                ),
              ),
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
                          color: primary,
                        ),
                        const SizedBox(width: 6),
                        Text('Start Date: ${program.startDate}'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      program.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(height: 1.4),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _openProgramDetails(program),
                      child: const Text('View Details'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
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
