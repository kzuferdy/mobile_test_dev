import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_test_dev/logic/dashboard/dashboard_bloc.dart';
import 'package:mobile_test_dev/models/user.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return _buildLoading();
          } else if (state is UserLoaded) {
            return _buildUserList(state.users);
          } else if (state is UserError) {
            return _buildError(state.message);
          }
          return Container(); // Default case, nothing to show
        },
      ),
    );
  }

  // Loading state widget
  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // Error state widget
  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error: $message',
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => context.read<UserBloc>().add(FetchUsers()),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  // User list widget
  Widget _buildUserList(List<User> users) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserBloc>().add(FetchUsers());
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return _buildUserTile(user);
        },
      ),
    );
  }

  // User list tile widget
  Widget _buildUserTile(User user) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          user.email,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        leading: const Icon(Icons.account_circle, size: 40, color: Colors.blueAccent),
        tileColor: Colors.white,
      ),
    );
  }
}
