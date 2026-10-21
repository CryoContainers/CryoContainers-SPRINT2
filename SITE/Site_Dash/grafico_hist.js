const labels = ['08h', '12h', '16h', '18h', '22h', '02h', '06h'];

const data = {
    labels: labels,
            datasets: [{
                label: 'Temperatura Interna (°C)',
                borderColor: '#E9A27C',
                backgroundColor: '#E9A27C',
                borderWidth: 2,
                data: [-20, -19, -15, -5, 2, 5, 1] 
            }]
        };

        const config = {
            type: 'line',
            data: data,
            options: {
                responsive: true, 
                scales: {
                    y: {
                        min: -25,
                        max: 10
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                },
                plugins: {
                    annotation: {
                        annotations: {
                            zonaSegura: {
                                type: 'box',
                                yMin: -25,
                                yMax: -18,
                                backgroundColor: 'rgba(14, 137, 146, 0.2)',
                                borderWidth: 0,
                            },
                            linhaCritica: {
                                type: 'line',
                                yMin: 4,
                                yMax: 4,
                                borderColor: '#e74c3c',
                                borderWidth: 2,
                                label: {
                                    display: true,
                                    content: 'Risco de Histamina (+4°C)',
                                    position: 'end',
                                    backgroundColor: '#e74c3c',
                                    color: 'white'
                                }
                            }
                        }
                    }
                }
            }
        }; 

        const chart_temperatura = new Chart(
            document.getElementById('grafico-historico'),
            config
        );
