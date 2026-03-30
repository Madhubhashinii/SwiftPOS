<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>SwiftPOS - Product Management</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        .main-content.products-bg-icon {
            position: relative;
            overflow: hidden;
        }

        .main-content.products-bg-icon::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('${pageContext.request.contextPath}/images/product-icon.png');
            background-repeat: no-repeat;
            background-position: center center;
            background-size: 250px;
            opacity: 0.08;
            z-index: 1;
            pointer-events: none;
        }

        .main-content .header,
        .main-content .action-bar,
        .main-content .card,
        .main-content .modal {
            position: relative;
            z-index: 2;
        }
    </style>
</head>
<body>
    <div class="animated-lines">
        <div class="line line-1"></div>
        <div class="line line-2"></div>
        <div class="line line-3"></div>
    </div>

    <div class="dashboard-container">
        <div class="sidebar">
            <div class="sidebar-brand">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="SwiftPOS">
                <span>SwiftPOS</span>
            </div>
            <ul class="sidebar-nav">
                <li>
                    <a href="${pageContext.request.contextPath}/admin_dashboard">
                        <i class="fas fa-tachometer-alt"></i> <span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/users">
                        <i class="fas fa-users"></i> <span>Users</span>
                    </a>
                </li>
                <li class="active">
                    <a href="${pageContext.request.contextPath}/products">
                        <i class="fas fa-boxes"></i> <span>Products</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/categories">
                        <i class="fas fa-tags"></i> <span>Categories</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/sales">
                        <i class="fas fa-shopping-cart"></i> <span>Sales</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/reports">
                        <i class="fas fa-chart-bar"></i> <span>Reports</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/about">
                        <i class="fas fa-cog"></i> <span>About</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/logout" class="sidebar-logout-btn">
                        <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content products-bg-icon">
            <div class="header">
                <h2>Product Management</h2>
                <div class="user-menu">
                    <div class="user-avatar">
                        ${fn:substring(sessionScope.user.username, 0, 1)}
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>

            <div class="action-bar">
                <button class="btn btn-primary" onclick="showAddProductForm()">
                    <i class="fas fa-plus-circle"></i> Add New Product
                </button>
                <div class="search-box">
                    <input type="text" placeholder="Search products..." id="productSearch">
                    <button class="search-btn"><i class="fas fa-search"></i></button>
                </div>
            </div>

            <!-- ✅ CHANGE 1: REMOVED DESCRIPTION FIELD -->
            <div id="addProductForm" class="card form-container" style="display: none;">
                <h3>Add New Product</h3>
                <form action="${pageContext.request.contextPath}/products?action=add" method="POST">
                    <div class="form-group">
                        <label>Product Name</label>
                        <input type="text" name="productName" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Category</label>
                        <select name="categoryId" class="form-control">
                            <option value="1">Beverages</option>
                            <option value="2">Snacks</option>
                            <option value="3">Electronics</option>
                            <option value="4">Apparel</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Price</label>
                        <input type="number" name="price" step="0.01" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Stock Quantity</label>
                        <input type="number" name="stockQuantity" required class="form-control">
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Save Product</button>
                        <button type="button" class="btn btn-outline" onclick="hideAddProductForm()">Cancel</button>
                    </div>
                </form>
            </div>

            <!-- ✅ CHANGE 2: REPLACED HARDCODED ROWS WITH DYNAMIC DATA -->
            <div class="card">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty products}">
                                <tr>
                                    <td colspan="6" style="text-align: center;">No products found. Click "Add New Product" to get started!</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${products}" var="product">
                                    <tr>
                                        <td data-label="ID">${product.id}</td>
                                        <td data-label="Name">${product.name}</td>
                                        <td data-label="Category">Category ${product.categoryId}</td>
                                        <td data-label="Price">LKR ${product.price}</td>
                                        <td data-label="Stock">
                                            <span class="badge ${product.stock > 100 ? 'badge-success' : 'badge-danger'}">
                                                ${product.stock}
                                            </span>
                                        </td>
                                        <td data-label="Actions" class="actions">
                                            <button class="btn btn-sm btn-outline"
                                                    onclick="showEditProductForm('${product.id}', '${product.name}', '${product.categoryId}', '${product.price}', '${product.stock}')">
                                                <i class="fas fa-edit"></i> Edit
                                            </button>
                                            <button class="btn btn-sm btn-danger"
                                                    onclick="confirmDeleteProduct('${product.id}')">
                                                <i class="fas fa-trash"></i> Delete
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- ✅ CHANGE 3: REMOVED DESCRIPTION FROM EDIT MODAL -->
            <div id="editProductModal" class="modal">
                <div class="modal-content card">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <h3>Edit Product</h3>
                    <form id="editForm" action="${pageContext.request.contextPath}/products?action=update" method="POST">
                        <input type="hidden" id="editProductId" name="id">
                        <div class="form-group">
                            <label>Product Name</label>
                            <input type="text" id="editProductName" name="productName" required class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Category</label>
                            <select id="editProductCategory" name="categoryId" class="form-control">
                                <option value="1">Beverages</option>
                                <option value="2">Snacks</option>
                                <option value="3">Electronics</option>
                                <option value="4">Apparel</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Price</label>
                            <input type="number" id="editProductPrice" name="price" step="0.01" required class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Stock Quantity</label>
                            <input type="number" id="editProductStock" name="stockQuantity" required class="form-control">
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                            <button type="button" class="btn btn-outline" onclick="closeModal()">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
                        
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/products.js"></script>
    <script>
        function showAddProductForm() {
            document.getElementById('addProductForm').style.display = 'block';
        }

        function hideAddProductForm() {
            document.getElementById('addProductForm').style.display = 'none';
        }

        // ✅ CHANGE 4: UPDATED JAVASCRIPT FUNCTION (REMOVED DESCRIPTION PARAMETER)
        function showEditProductForm(id, name, categoryId, price, stock) {
            const modal = document.getElementById('editProductModal');

            document.getElementById('editProductId').value = id;
            document.getElementById('editProductName').value = name;
            document.getElementById('editProductPrice').value = price;
            document.getElementById('editProductStock').value = stock;

            // Set category by ID
            document.getElementById('editProductCategory').value = categoryId;

            modal.style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('editProductModal').style.display = 'none';
        }

        function confirmDeleteProduct(id) {
            if (confirm('Are you sure you want to delete product with ID: ' + id + '? This action cannot be undone.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/products?action=delete';

                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'id';
                input.value = id;
                form.appendChild(input);

                document.body.appendChild(form);
                form.submit();
            }
        }

        window.onclick = function(event) {
            const modal = document.getElementById('editProductModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        }
        
          function showAddProductForm() {
        document.getElementById('addProductForm').style.display = 'block';
    }

    function hideAddProductForm() {
        document.getElementById('addProductForm').style.display = 'none';
    }

    function showEditProductForm(id, name, categoryId, price, stock) {
        const modal = document.getElementById('editProductModal');

        document.getElementById('editProductId').value = id;
        document.getElementById('editProductName').value = name;
        document.getElementById('editProductPrice').value = price;
        document.getElementById('editProductStock').value = stock;
        document.getElementById('editProductCategory').value = categoryId;

        modal.style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('editProductModal').style.display = 'none';
    }

    function confirmDeleteProduct(id) {
        if (confirm('Are you sure you want to delete product with ID: ' + id + '? This action cannot be undone.')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/products?action=delete';

            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'id';
            input.value = id;
            form.appendChild(input);

            document.body.appendChild(form);
            form.submit();
        }
    }

    // ✅ NEW: SEARCH FUNCTIONALITY
    document.getElementById('productSearch').addEventListener('keyup', function() {
        const searchValue = this.value.toLowerCase();
        const tableRows = document.querySelectorAll('.table tbody tr');

        tableRows.forEach(function(row) {
            const productName = row.querySelector('td:nth-child(2)')?.textContent.toLowerCase() || '';
            const productId = row.querySelector('td:nth-child(1)')?.textContent.toLowerCase() || '';
            const category = row.querySelector('td:nth-child(3)')?.textContent.toLowerCase() || '';

            if (productName.includes(searchValue) || productId.includes(searchValue) || category.includes(searchValue)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });

    // ✅ NEW: SEARCH BUTTON CLICK
    document.querySelector('.search-btn').addEventListener('click', function() {
        document.getElementById('productSearch').focus();
    });

    window.onclick = function(event) {
        const modal = document.getElementById('editProductModal');
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    }
        
    </script>
</body>
</html>



    