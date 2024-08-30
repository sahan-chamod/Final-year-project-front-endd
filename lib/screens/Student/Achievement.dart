import 'package:flutter/material.dart';

class AchievementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements & Leaderboard'),
        backgroundColor: Colors.teal.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildAchievementsSection(),
            SizedBox(height: 20),
            _buildLeaderboardSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Achievements',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.teal.shade300,
            ),
          ),
          SizedBox(height: 10),
          _buildAchievementCard(
            title: 'Top Scorer',
            description: 'Achieved the highest score in the recent quiz.',
          ),
          _buildAchievementCard(
            title: 'Best Project',
            description: 'Awarded for the best project presentation.',
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard({
    required String title,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.teal.shade50,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(description),
      ),
    );
  }

  Widget _buildLeaderboardSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Leaderboard',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.teal.shade300,
            ),
          ),
          SizedBox(height: 10),
          _buildLeaderboardEntry(
            rank: 1,
            name: 'Alice Johnson',
            score: 980,
            icon: Icons.star,
          ),
          _buildLeaderboardEntry(
            rank: 2,
            name: 'Bob Smith',
            score: 940,
            icon: Icons.star_border,
          ),
          _buildLeaderboardEntry(
            rank: 3,
            name: 'Charlie Davis',
            score: 920,
            icon: Icons.star_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardEntry({
    required int rank,
    required String name,
    required int score,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.teal.shade50,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade300,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$rank. $name',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        trailing: Text(
          '$score points',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade300,
          ),
        ),
      ),
    );
  }
}
