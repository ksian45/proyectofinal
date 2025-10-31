<%-- 
    Document   : reportes
    Created on : 28/10/2025, 9:19:06 p. m.
    Author     : Jruiz
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reportes del Sistema</title>

    <!-- Bootstrap y Chart.js -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>

    <style>
        body {
            background: linear-gradient(135deg, #e3f2fd, #ffffff);
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
        }

        .container {
            margin-top: 60px;
            max-width: 1100px;
        }

        .card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            background-color: #fff;
            overflow: hidden;
        }

        h2 {
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            background: linear-gradient(90deg, #007BFF, #0056d2);
            border: none;
            border-radius: 10px;
            transition: all 0.3s ease-in-out;
        }

        .btn-primary:hover {
            transform: scale(1.03);
            box-shadow: 0 4px 10px rgba(0, 123, 255, 0.4);
        }

        .btn-success {
            border-radius: 10px;
        }

        .table thead {
            background: linear-gradient(90deg, #007BFF, #00a2ff);
            color: white;
            font-weight: 600;
        }

        .chart-container {
            position: relative;
            height: 400px;
            width: 100%;
        }

        footer {
            margin-top: 40px;
            text-align: center;
            color: #6c757d;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card p-5" id="contenidoReporte">
        <h2 class="text-center text-primary mb-4">📊  Reportes</h2>

        <!-- Formulario -->
        <form method="post" action="<%= request.getContextPath() %>/reporte" class="text-center mb-4">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <select name="tipoReporte" class="form-select mb-3" required>
                        <option value="" disabled selected>Selecciona un tipo de reporte</option>
                        <option value="ventas">Ventas</option>
                        <option value="compras">Compras</option>
                    </select>
                    <button type="submit" class="btn btn-primary w-100">Generar Reporte</button>
                </div>
            </div>
        </form>

        <!-- Mensajes de error -->
        <%
            String error = (String) request.getAttribute("error");
            if (error != null && !error.isEmpty()) {
        %>
            <div class="alert alert-danger text-center"><%= error %></div>
        <% } %>

        <!-- Tabla y gráfico -->
        <%
            List<String> columnas = (List<String>) request.getAttribute("columnas");
            List<List<String>> filas = (List<List<String>>) request.getAttribute("filas");

            if (columnas != null && filas != null && !filas.isEmpty()) {
        %>
        <div class="table-responsive mt-4">
            <table class="table table-bordered table-hover text-center align-middle">
                <thead>
                    <tr>
                        <% for (String col : columnas) { %>
                            <th><%= col %></th>
                        <% } %>
                    </tr>
                </thead>
                <tbody>
                    <% for (List<String> fila : filas) { %>
                        <tr>
                            <% for (String valor : fila) { %>
                                <td><%= valor %></td>
                            <% } %>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Gráfico -->
        <div class="chart-container mt-5">
            <canvas id="graficoReporte"></canvas>
        </div>

        <!-- Botón de descarga PDF -->
        <div class="text-center mt-4">
            <button id="btnDescargar" class="btn btn-success">
                📥 Descargar PDF
            </button>
        </div>

        <script>
            const labels = [];
            const valores = [];

            <% 
                for (List<String> fila : filas) {
                    String etiqueta = fila.get(0);
                    String valor = "0";
                    for (String item : fila) {
                        if (item.matches("\\d+(\\.\\d+)?")) { valor = item; break; }
                    }
            %>
                labels.push("<%= etiqueta %>");
                valores.push(<%= valor %>);
            <% } %>

            const ctx = document.getElementById("graficoReporte");
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Valores del Reporte',
                        data: valores,
                        backgroundColor: 'rgba(0, 123, 255, 0.6)',
                        borderColor: '#007BFF',
                        borderWidth: 1,
                        borderRadius: 8
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: { beginAtZero: true }
                    },
                    plugins: {
                        legend: { display: true, position: 'bottom' },
                        title: { display: true, text: 'Gráfico del Reporte', font: { size: 18 } }
                    }
                }
            });

            // Descargar PDF
            document.getElementById("btnDescargar").addEventListener("click", async () => {
                const { jsPDF } = window.jspdf;
                const pdf = new jsPDF('p', 'mm', 'a4');
                const contenido = document.getElementById("contenidoReporte");

                await html2canvas(contenido, { scale: 2 }).then(canvas => {
                    const imgData = canvas.toDataURL("image/png");
                    const imgWidth = 190;
                    const pageHeight = 295;
                    const imgHeight = canvas.height * imgWidth / canvas.width;
                    let heightLeft = imgHeight;
                    let position = 10;

                    pdf.addImage(imgData, 'PNG', 10, position, imgWidth, imgHeight);
                    heightLeft -= pageHeight;

                    while (heightLeft >= 0) {
                        position = heightLeft - imgHeight;
                        pdf.addPage();
                        pdf.addImage(imgData, 'PNG', 10, position, imgWidth, imgHeight);
                        heightLeft -= pageHeight;
                    }

                    pdf.save("reporte.pdf");
                });
            });
        </script>

        <% } else if (columnas != null) { %>
            <div class="alert alert-warning text-center">No hay datos disponibles para este reporte.</div>
        <% } %>
    </div>

    <footer class="mt-5">
        <p>© 2025 Sistema de Reportes </p>
    </footer>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
