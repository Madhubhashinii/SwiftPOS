<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>SwiftPOS - Receipt</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/receipt.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        .top-logout-btn {
            position: fixed;
            top: 15px;
            right: 15px;
            background-color: #e74c3c;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 5px;
            font-weight: bold;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        
        .top-logout-btn:hover {
            background-color: #c0392b;
        }
        
        .sidebar-logout {
            margin-top: auto;
            border-top: 1px solid #34495e;
        }
        
        .sidebar-logout a {
            color: #e74c3c !important;
        }
    </style>
</head>
<body>
    <!-- Red logout button in top right corner -->
    <button class="top-logout-btn" onclick="window.location.href='${pageContext.request.contextPath}/logout'">
        <i class="fas fa-sign-out-alt"></i> Logout
    </button>

    <div class="animated-lines">
        <div class="line line-1"></div>
        <div class="line line-2"></div>
        <div class="line line-3"></div>
    </div>

    <div class="dashboard-container">
        <!-- Sidebar -->
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
                <li>
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
                <li class="active">
                    <a href="${pageContext.request.contextPath}/receipt">
                        <i class="fas fa-receipt"></i> <span>Receipts</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/settings">
                        <i class="fas fa-cog"></i> <span>Settings</span>
                    </a>
                </li>
                <li class="sidebar-logout">
                    <a href="${pageContext.request.contextPath}/logout">
                        <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content receipt-bg-icon">
            <div class="header">
                <h2>Transaction Receipt</h2>
                <div class="user-menu">
                    <div class="user-avatar">
                        ${fn:substring(sessionScope.user.username, 0, 1)}
                    </div>
                    <div>
                        <div class="user-name">${sessionScope.user.username}</div>
                        <div class="user-role">${sessionScope.user.role}</div>
                    </div>
                </div>
            </div>

            <!-- Receipt Container -->
            <div class="receipt-container animate__animated animate__fadeIn">
                <!-- Receipt Actions -->
                <div class="receipt-actions animate__animated animate__fadeInDown">
                    <button class="btn btn-primary" onclick="window.print()">
                        <i class="fas fa-print"></i> Print Receipt
                    </button>
                    <button class="btn btn-outline" onclick="window.location.href='${pageContext.request.contextPath}/sales'">
                        <i class="fas fa-cash-register"></i> New Sale
                    </button>
                    <button class="btn btn-outline" onclick="window.location.href='${pageContext.request.contextPath}/reports'">
                        <i class="fas fa-chart-line"></i> View Reports
                    </button>
                </div>

                <!-- Receipt Paper -->
                <div class="receipt-paper animate__animated animate__fadeInUp">
                    <!-- Receipt Header -->
                    <div class="receipt-header">
                        <img src="${pageContext.request.contextPath}/images/receipt-logo.png" alt="SwiftPOS" class="animate__animated animate__zoomIn">
                        <h3 class="animate__animated animate__fadeIn">SwiftPOS Mart</h3>
                        <p class="animate__animated animate__fadeIn">No. 123, Main Street, Galle, Sri Lanka</p>
                        <p class="animate__animated animate__fadeIn">Phone: 077-1234567</p>
                    </div>

                    <!-- Receipt Info -->
                    <div class="receipt-info animate__animated animate__fadeIn">
                        <div class="info-row">
                            <span>Receipt #:</span>
                            <strong>${receipt.receiptNumber}</strong>
                        </div>
                        <div class="info-row">
                            <span>Date:</span>
                            <span>${receipt.date}</span>
                        </div>
                        <div class="info-row">
                            <span>Time:</span>
                            <span>${receipt.time}</span>
                        </div>
                        <div class="info-row">
                            <span>Cashier:</span>
                            <span>${receipt.cashier}</span>
                        </div>
                    </div>

                    <!-- Receipt Items -->
                    <div class="receipt-items">
                        <div class="items-header animate__animated animate__fadeIn">
                            <span>Item</span>
                            <span>Qty</span>
                            <span>Price</span>
                            <span>Total</span>
                        </div>
                        
                        <c:forEach items="${receipt.items}" var="item" varStatus="loop">
                        <div class="item-row animate__animated animate__fadeIn" style="animation-delay: ${loop.index * 0.1}s">
                            <span class="item-name">${item.name}</span>
                            <span class="item-qty">${item.quantity}</span>
                            <span class="item-price">LKR ${item.price}</span>
                            <span class="item-total">LKR ${item.total}</span>
                        </div>
                        </c:forEach>
                    </div>

                    <!-- Receipt Summary -->
                    <div class="receipt-summary animate__animated animate__fadeIn">
                        <div class="summary-row">
                            <span>Subtotal:</span>
                            <span>LKR ${receipt.subtotal}</span>
                        </div>
                        <div class="summary-row">
                            <span>Discount:</span>
                            <span>LKR ${receipt.discount}</span>
                        </div>
                        <div class="summary-row">
                            <span>Tax (12%):</span>
                            <span>LKR ${receipt.tax}</span>
                        </div>
                        <div class="summary-row total">
                            <span>Total:</span>
                            <span>LKR ${receipt.total}</span>
                        </div>
                        <div class="summary-row">
                            <span>Payment Method:</span>
                            <span>${receipt.paymentMethod}</span>
                        </div>
                        <c:if test="${receipt.paymentMethod == 'Cash'}">
                        <div class="summary-row">
                            <span>Amount Received:</span>
                            <span>LKR ${receipt.amountReceived}</span>
                        </div>
                        <div class="summary-row">
                            <span>Change:</span>
                            <span>LKR ${receipt.change}</span>
                        </div>
                        </c:if>
                    </div>

                    <!-- Receipt Footer -->
                    <div class="receipt-footer animate__animated animate__fadeIn">
                        <p>Thank you for shopping with us!</p>
                        <p>Please visit again</p>
                        <div class="barcode">
                            <img src="${pageContext.request.contextPath}/images/barcode.png" alt="Barcode">
                        </div>
                        <small>Generated by SwiftPOS v1.0</small>
                    </div>
                </div>

                <!-- Customer Copy Notice -->
                <div class="customer-copy animate__animated animate__fadeInUp">
                    <i class="fas fa-user-circle"></i>
                    <span>Customer Copy</span>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Add animation when page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Add pulse animation to total amount
            setTimeout(function() {
                const totalElement = document.querySelector('.receipt-summary .total');
                totalElement.classList.add('animate__animated', 'animate__pulse', 'animate__repeat-2');
            }, 1000);
            
            // Add animation to print button on hover
            const printBtn = document.querySelector('.btn-primary');
            printBtn.addEventListener('mouseenter', function() {
                this.classList.add('animate__pulse');
            });
            printBtn.addEventListener('mouseleave', function() {
                this.classList.remove('animate__pulse');
            });
        });

        // Print-specific styles
        window.onbeforeprint = function() {
            document.querySelector('.dashboard-container').classList.add('print-mode');
            document.querySelector('.receipt-paper').classList.add('print-mode');
        };
        
        window.onafterprint = function() {
            document.querySelector('.dashboard-container').classList.remove('print-mode');
            document.querySelector('.receipt-paper').classList.remove('print-mode');
        };
    </script>
</body>
</html>
