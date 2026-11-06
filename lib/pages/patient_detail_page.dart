import 'package:flutter/material.dart';

class PatientDetailPage extends StatelessWidget {
  const PatientDetailPage({super.key, required this.patient});

  final Map<String, dynamic> patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do paciente'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (patient['nome'] ?? 'Paciente').toString(),
              style: const TextStyle(
                  fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            _info('Idade', '${patient['idade'] ?? '-'} anos'),
            _info('Telefone', (patient['telefone'] ?? '-').toString()),
            _info('Atendimento',
                (patient['tipoAtendimento'] ?? '-').toString()),
            _info('Alergia informada',
                patient['possuiAlergia'] == true ? 'Sim' : 'Não'),
          ],
        ),
      ),
    );
  }

  Widget _info(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          children: [
            Expanded(
                child: Text(label,
                    style: const TextStyle(fontWeight: FontWeight.w600))),
            Expanded(child: Text(value)),
          ],
        ),
      );
}
