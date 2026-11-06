import 'package:flutter/material.dart';

import 'patient_form_page.dart';
import 'patient_list_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.firebaseConfigurado});

  final bool firebaseConfigurado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProjetoHosp'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF176B87),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const Positioned(
                  right: 18,
                  top: 16,
                  child: Icon(Icons.local_hospital,
                      size: 76, color: Colors.white24),
                ),
                const Positioned(
                  left: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gestão hospitalar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 6),
                      Text('Bem-vindo ao painel do sistema',
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: firebaseConfigurado
                    ? Colors.green.shade50
                    : Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    firebaseConfigurado
                        ? Icons.cloud_done
                        : Icons.cloud_off,
                    color: firebaseConfigurado
                        ? Colors.green.shade800
                        : Colors.orange.shade900,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      firebaseConfigurado
                          ? 'Firebase conectado'
                          : 'Firebase pendente de configuração. Consulte o README.',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Acesso rápido',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _MenuCard(
                    icon: Icons.person_add_alt_1,
                    title: 'Cadastrar paciente',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PatientFormPage(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MenuCard(
                    icon: Icons.groups,
                    title: 'Pacientes cadastrados',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PatientListPage(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            const Text(
              'Projeto acadêmico. Utilize somente dados fictícios durante os testes.',
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard(
      {required this.icon, required this.title, required this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 38, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 10),
              Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
