import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocimetro/viewmodels/speedmeter_viewmodel.dart';

class SpeedometerScreen extends StatelessWidget {
  const SpeedometerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SpeedometerViewModel>(
      builder: (context, viewModel, child) {
        final mainContent = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'VELOCIDADE',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Text(
              viewModel.data.currentSpeed.toStringAsFixed(1),
              style: TextStyle(
                color: viewModel.isHudMode
                    ? Colors.greenAccent
                    : Colors.lightGreenAccent,
                fontSize: 120,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'km/h',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 40),
            const Text(
              'DISTÂNCIA',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Text(
              '${viewModel.data.totalDistance.toStringAsFixed(2)} km',
              style: const TextStyle(color: Colors.white, fontSize: 40),
            ),
            const SizedBox(height: 60),
            if (!viewModel.isHudMode)
              ElevatedButton(
                onPressed: viewModel.resetDistance,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                ),
                child: const Text(
                  'ZERAR DISTÂNCIA',
                  style: TextStyle(fontSize: 18),
                ),
              ),
          ],
        );

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: viewModel.isHudMode
              ? null
              : AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  title: const Text('Velocímetro GPS'),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.screen_rotation_outlined),
                      onPressed: viewModel.toggleHudMode,
                      tooltip: 'Modo HUD',
                    ),
                  ],
                ),
        
          body: Center(
          
            child: SingleChildScrollView(
              child: viewModel.isHudMode
                  ? Transform.scale(scaleX: -1, child: mainContent)
                  : mainContent,
            ),
          ),
          floatingActionButton: viewModel.isHudMode
              ? FloatingActionButton.extended(
                  onPressed: viewModel.toggleHudMode,
                  label: const Text('Sair do Modo HUD'),
                  icon: const Icon(Icons.close),
                  backgroundColor: Colors.white24,
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
