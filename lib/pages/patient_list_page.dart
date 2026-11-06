import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'patient_detail_page.dart';

class PatientListPage extends StatelessWidget {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes cadastrados'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('pacientes')
            .orderBy('criadoEm', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text('Não foi possível carregar os pacientes.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text('Nenhum paciente cadastrado.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data();
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text((data['nome'] ?? 'P').toString()[0]
                        .toUpperCase()),
                  ),
                  title: Text((data['nome'] ?? 'Sem nome').toString()),
                  subtitle: Text('Idade: ${data['idade'] ?? '-'}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PatientDetailPage(patient: data),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
