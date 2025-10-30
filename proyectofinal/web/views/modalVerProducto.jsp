<%-- 
    Document   : modalVerProducto
    Created on : 25/10/2025, 4:28:03 p. m.
    Author     : guich
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="modal fade" id="modalVerProducto" tabindex="-1" aria-labelledby="modalVerProductoLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            
            <div class="modal-header">
                <h5 class="modal-title" id="modalVerProductoLabel">Detalle del Producto</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-5 text-center">
                        <img id="imgVerProducto" src="https://placehold.co/300x300/EFEFEF/AAAAAA&text=Imagen" alt="Imagen del Producto" class="img-fluid img-thumbnail" style="max-height: 300px; object-fit: contain;">
                    </div>
                    
                    <div class="col-md-7">
                        <h3><strong id="verProductoNombre">[Nombre del Producto]</strong></h3>
                        
                        <p class="h5 text-muted"><span id="verProductoMarca">[Marca]</span></p>
                        <hr>
                        
                        <p><strong>Descripción:</strong></p>
                        <p id="verProductoDescripcion">[Descripción detallada del producto...]</p>
                        <hr>
                        
                        <div class="row">
                            <div class="col-6">
                                <p><strong>Precio Costo:</strong><br> <span id="verProductoCosto"></span></p>
                                <p><strong>Precio Venta:</strong><br> <span id="verProductoVenta"></span></p>
                            </div>
                            <div class="col-6">
                                <p><strong>Stock:</strong><br> <span id="verProductoStock"></span></p>
                                <p><strong>Fecha Ingreso:</strong><br> <span id="verProductoIngreso"></span></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            </div>
            
        </div>
    </div>
</div>
