<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>SwiftPOS - Sales</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sales.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .top-logout-btn {
            position: fixed; top: 15px; right: 15px;
            background-color: #e74c3c; color: white;
            padding: 8px 15px; border: none; border-radius: 4px;
            cursor: pointer; z-index: 1000; display: flex;
            align-items: center; gap: 5px; font-weight: bold;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .top-logout-btn:hover { background-color: #c0392b; }
        .sidebar-logout { margin-top: auto; border-top: 1px solid #34495e; }
        .sidebar-logout a { color: #e74c3c !important; }
        
        /* Category Filter UI */
        .category-filter { display: flex; gap: 10px; margin: 15px 0; overflow-x: auto; padding-bottom: 5px; }
        .category-btn {
            padding: 8px 18px; border-radius: 20px; border: 1px solid #ddd;
            background: #fff; cursor: pointer; white-space: nowrap; transition: 0.2s;
        }
        .category-btn.active { background-color: #3f37c9; color: white; border-color: #3f37c9; }

        /* Modal Styles */
        .modal {
            display: none; position: fixed; z-index: 2000;
            left: 0; top: 0; width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.6);
        }
        .modal-content {
            background-color: #fff; margin: 10% auto;
            padding: 25px; border-radius: 8px; width: 400px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
        .payment-amount, .payment-amount-received, #changeDue {
            display: flex; justify-content: space-between; margin: 15px 0; font-size: 1.1rem;
        }
        #changeDue { font-weight: bold; border-top: 1px solid #eee; padding-top: 10px; }
        .btn-confirm { width: 100%; padding: 12px; background: #27ae60; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 1rem; }
        input[type="number"] { padding: 8px; border: 1px solid #ddd; border-radius: 4px; }

        .out-of-stock { opacity: 0.5; pointer-events: none; position: relative; }
        .out-of-stock::after { 
            content: "OUT OF STOCK"; position: absolute; top: 50%; left: 50%; 
            transform: translate(-50%, -50%); color: red; font-weight: bold; 
            border: 2px solid red; padding: 5px; background: white;
        }
    </style>
</head>
<body>
    <button class="top-logout-btn" onclick="window.location.href='${pageContext.request.contextPath}/logout'">
        <i class="fas fa-sign-out-alt"></i> Logout
    </button>

    <div class="dashboard-container">
        <div class="sidebar">
            <div class="sidebar-brand">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="SwiftPOS">
                <span>SwiftPOS</span>
            </div>
            <ul class="sidebar-nav">
                <li><a href="${pageContext.request.contextPath}/admin_dashboard"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a></li>
                <li><a href="${pageContext.request.contextPath}/users"><i class="fas fa-users"></i> <span>Users</span></a></li>
                <li><a href="${pageContext.request.contextPath}/products"><i class="fas fa-boxes"></i> <span>Products</span></a></li>
                <li><a href="${pageContext.request.contextPath}/categories"><i class="fas fa-tags"></i> <span>Categories</span></a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/sales"><i class="fas fa-shopping-cart"></i> <span>Sales</span></a></li>
                <li><a href="${pageContext.request.contextPath}/reports"><i class="fas fa-chart-bar"></i> <span>Reports</span></a></li>
                <li><a href="${pageContext.request.contextPath}/about"><i class="fas fa-cog"></i> <span>About</span></a></li>
                <li class="sidebar-logout"><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="header">
                <h2>Point of Sale</h2>
                <div class="user-menu">
                    <div class="user-avatar">${fn:substring(sessionScope.user.username, 0, 1)}</div>
                </div>
            </div>

            <div class="pos-container">
                <div class="pos-product-selector">
                    <div class="search-box">
                        <input type="text" id="productSearch" placeholder="Search products..." autofocus>
                        <button class="search-btn"><i class="fas fa-search"></i></button>
                    </div>

                    <div class="category-filter">
                        <button class="category-btn active" data-category="all">All</button>
                        <c:forEach items="${categories}" var="category">
                            <button class="category-btn" data-category="${category.id}">${category.name}</button>
                        </c:forEach>
                    </div>
                    
                    <div class="product-grid">
                        <c:forEach items="${products}" var="product">
                            <div class="product-item" 
                                 data-id="${product.id}" 
                                 data-price="${product.price}" 
                                 data-stock="${product.stock}"
                                 data-category="${product.categoryId}">
                                <div class="product-info">
                                    <h4>${product.name}</h4>
                                    <p class="product-price">LKR ${product.price}</p>
                                    <p class="product-stock">Available: <span class="stock-display">${product.stock}</span></p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                
                <div class="pos-cart-container">
                    <div class="cart-header"><h3>Current Sale</h3></div>
                    <div class="cart-items">
                        <table class="cart-table">
                            <thead>
                                <tr><th>Item</th><th>Qty</th><th>Price</th><th>Total</th><th></th></tr>
                            </thead>
                            <tbody id="cartItems"></tbody>
                        </table>
                    </div>
                    
                    <div class="cart-summary">
                        <div class="summary-row"><span>Subtotal:</span><span id="subtotal">LKR 0.00</span></div>
                        <div class="summary-row">
                            <span>Discount:</span>
                            <div class="discount-control">
                                <input type="number" id="discount" value="0" min="0" max="100">
                                <span>%</span>
                            </div>
                        </div>
                        <div class="summary-row"><span>Tax (12%):</span><span id="tax">LKR 0.00</span></div>
                        <div class="summary-row total"><span>Total:</span><span id="total">LKR 0.00</span></div>
                    </div>
                    
                    <div class="cart-actions">
                        <button class="btn btn-clear" id="clearCart"><i class="fas fa-trash"></i> Clear</button>
                        <button class="btn btn-complete" id="completeSale"><i class="fas fa-check-circle"></i> Complete</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="paymentModal" class="modal">
        <div class="modal-content">
            <span class="close" style="cursor:pointer; float:right; font-size:28px;">&times;</span>
            <h3>Process Payment</h3>
            <div class="payment-details">
                <div class="payment-amount">
                    <span>Total Amount:</span>
                    <span id="paymentTotal">LKR 0.00</span>
                </div>
                <div class="payment-method" style="margin-bottom: 15px;">
                    <label style="display:block; margin-bottom:5px;">Payment Method:</label>
                    <select id="paymentMethod" style="width:100%; padding:8px;">
                        <option value="cash">Cash</option>
                        <option value="card">Credit Card</option>
                    </select>
                </div>
                <div class="payment-amount-received" style="flex-direction:column; align-items:flex-start;">
                    <label style="margin-bottom:5px;">Amount Received:</label>
                    <input type="number" id="amountReceived" step="0.01" style="width:100%;">
                </div>
                <div id="changeDue">
                    <span>Change Due:</span>
                    <span>LKR 0.00</span>
                </div>
                <button class="btn btn-confirm" id="confirmPayment">Confirm Payment</button>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            let cart = [];

            // CATEGORY FILTERING
            $('.category-btn').click(function() {
                $('.category-btn').removeClass('active');
                $(this).addClass('active');
                const cat = $(this).data('category');
                if (cat === 'all') {
                    $('.product-item').fadeIn(200);
                } else {
                    $('.product-item').hide();
                    $(`.product-item[data-category="\${cat}"]`).fadeIn(200);
                }
            });

            // SEARCH FILTERING
            $('#productSearch').on('input', function() {
                const searchText = $(this).val().toLowerCase();
                $('.product-item').each(function() {
                    const name = $(this).find('h4').text().toLowerCase();
                    $(this).toggle(name.includes(searchText));
                });
            });

            // ADD TO CART
            $('.product-item').click(function() {
                const productId = $(this).data('id');
                const productName = $(this).find('h4').text();
                const productPrice = parseFloat($(this).data('price'));
                const originalStock = parseInt($(this).data('stock'));
                const existingItem = cart.find(item => item.id === productId);
                
                if (existingItem) {
                    if (existingItem.quantity < originalStock) {
                        existingItem.quantity += 1;
                    } else { alert("Insufficient stock available!"); return; }
                } else {
                    if (originalStock > 0) {
                        cart.push({ id: productId, name: productName, price: productPrice, quantity: 1, maxStock: originalStock });
                    } else { alert("Product is out of stock!"); return; }
                }
                updateCart();
            });

            function updateCart() {
                const cartTable = $('#cartItems');
                cartTable.empty();
                let subtotal = 0;

                $('.product-item').each(function() {
                    $(this).find('.stock-display').text($(this).data('stock'));
                    $(this).removeClass('out-of-stock');
                });

                cart.forEach(item => {
                    const price = parseFloat(item.price) || 0;
                    const itemTotal = price * item.quantity;
                    subtotal += itemTotal;

                    const productDiv = $(`.product-item[data-id="\${item.id}"]`);
                    const remaining = item.maxStock - item.quantity;
                    productDiv.find('.stock-display').text(remaining);
                    if (remaining <= 0) productDiv.addClass('out-of-stock');

                    const row = `<tr>
                        <td>\${item.name}</td>
                        <td><input type="number" class="quantity-input" value="\${item.quantity}" data-id="\${item.id}" style="width: 50px;" min="1" max="\${item.maxStock}"></td>
                        <td>LKR \${price.toFixed(2)}</td>
                        <td>LKR \${itemTotal.toFixed(2)}</td>
                        <td><button class="btn-remove" data-id="\${item.id}" style="color:red; border:none; background:none; cursor:pointer;"><i class="fas fa-times"></i></button></td>
                    </tr>`;
                    cartTable.append(row);
                });

                const discount = parseFloat($('#discount').val()) || 0;
                const discountAmt = subtotal * (discount / 100);
                const tax = (subtotal - discountAmt) * 0.12;
                const total = (subtotal - discountAmt) + tax;

                $('#subtotal').text('LKR ' + subtotal.toFixed(2));
                $('#tax').text('LKR ' + tax.toFixed(2));
                $('#total').text('LKR ' + total.toFixed(2));
                $('#paymentTotal').text('LKR ' + total.toFixed(2));
            }

            // Real-time updates
            $('#discount').on('input', updateCart);
            $(document).on('change', '.quantity-input', function() {
                const id = $(this).data('id');
                const newQty = parseInt($(this).val());
                const item = cart.find(i => i.id === id);
                if (item) {
                    if (newQty > item.maxStock) {
                        alert("Max stock reached"); $(this).val(item.maxStock); item.quantity = item.maxStock;
                    } else if (newQty > 0) { item.quantity = newQty; }
                    updateCart();
                }
            });

            $('#amountReceived').on('input', function() {
                const total = parseFloat($('#paymentTotal').text().replace('LKR ', '')) || 0;
                const received = parseFloat($(this).val()) || 0;
                const change = received - total;
                $('#changeDue span:last-child').text('LKR ' + (change >= 0 ? change.toFixed(2) : '0.00'));
                $('#changeDue').css('color', change >= 0 ? 'green' : 'red');
            });

            // Action Buttons
            $('#clearCart').click(function() { if(cart.length > 0 && confirm('Clear sale?')) { cart = []; updateCart(); } });
            $(document).on('click', '.btn-remove', function() { cart = cart.filter(i => i.id !== $(this).data('id')); updateCart(); });
            $('#completeSale').click(function() { if(cart.length === 0) return alert("Cart is empty"); $('#amountReceived').val(''); $('#paymentModal').show(); });
            $('.close').click(function() { $('#paymentModal').hide(); });

            // FULL RESTORED PAYMENT LOGIC
            $('#confirmPayment').click(function() {
                const total = parseFloat($('#paymentTotal').text().replace('LKR ', ''));
                const received = parseFloat($('#amountReceived').val()) || 0;
                
                if (received < total) { alert('Insufficient amount received!'); return; }

                const saleData = {
                    total: total,
                    discount: $('#discount').val(),
                    received: received,
                    change: received - total,
                    paymentMethod: $('#paymentMethod').val(),
                    items: cart
                };

                $.post('${pageContext.request.contextPath}/sales', {
                    saleData: JSON.stringify(saleData)
                }, function(response) {
                    if (response.success) {
                        printReceipt(saleData); 
                        location.reload();
                    } else {
                        alert('Error: ' + response.message);
                    }
                }, 'json');
            });

            function printReceipt(data) {
                let receipt = "--- SwiftPOS RECEIPT ---\n\n";
                data.items.forEach(item => {
                    receipt += `\${item.name} x \${item.quantity} = LKR \${(item.price * item.quantity).toFixed(2)}\n`;
                });
                receipt += "\n----------------------";
                receipt += "\nTotal: LKR " + data.total.toFixed(2);
                receipt += "\nReceived: LKR " + data.received.toFixed(2);
                receipt += "\nChange: LKR " + data.change.toFixed(2);
                receipt += "\n----------------------\nThank you for your purchase!";
                alert(receipt);
            }
        });
    </script>
</body>
</html>