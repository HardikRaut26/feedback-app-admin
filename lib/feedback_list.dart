import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedbackListScreen extends StatefulWidget {
  const FeedbackListScreen({super.key});

  @override
  State<FeedbackListScreen> createState() => _FeedbackListScreenState();
}

class _FeedbackListScreenState extends State<FeedbackListScreen> {
  List<dynamic> feedbackList = [];
  bool isLoading = false;

  Future<void> fetchFeedback() async {
    setState(() {
      isLoading = true;
    });
    final response = await Supabase.instance.client
        .from('feedback')
        .select()
        .order('created_at', ascending: false);

    setState(() {
      feedbackList = response;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFeedback();
  }

  Widget _buildFeedbackItem(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Text(
                  item['name'] ?? 'No Name',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(item['email'] ?? '', style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Text(item['phone'] ?? '', style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.cake, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Text(item['birth_date'] ?? '', style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.home, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(item['address'] ?? '', style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.comment, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(item['comments'] ?? '', style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '📅 Submitted: ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(item['created_at']))}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Feedback'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchFeedback,
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: fetchFeedback,
        child: feedbackList.isEmpty
            ? const Center(child: Text('No feedback found.'))
            : ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: feedbackList.length,
          itemBuilder: (context, index) {
            final item = feedbackList[index];
            return _buildFeedbackItem(item);
          },
        ),
      ),
    );
  }
}
