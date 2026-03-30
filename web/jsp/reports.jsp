<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>SwiftPOS - Reports</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/report.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* Additional style for the logout button */
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
        
        .top-logout-btn i {
            margin-right: 5px;
        }
        
        .sidebar-logout {
            margin-top: auto;
            border-top: 1px solid #34495e;
        }
        
        .sidebar-logout a {
            color: #e74c3c !important;
        }
        
        .sidebar-logout a:hover {
            background-color: rgba(231, 76, 60, 0.1) !important;
        }

        /* Clear Data Form adjustment */
        .clear-history-form {
            display: inline-block;
            margin: 0;
            padding: 0;
        }
        
        .report-actions {
    display: flex;
    align-items: center;
    gap: 10px; /* Spacing between search bar and buttons */
}

.btn-clear {
    display: inline-flex;
    align-items: center;
    background-color: #ff4d4d; /* Red for destructive action */
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.1s ease;
    height: 38px; /* Matches standard input height */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.btn-clear i {
    margin-right: 8px; /* Space between trash icon and text */
}

.btn-clear:hover {
    background-color: #e60000;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.btn-clear:active {
    transform: scale(0.98);
}
    </style>
</head>
<body>
    <button class="top-logout-btn" onclick="window.location.href='${pageContext.request.contextPath}/logout'">
        <i class="fas fa-sign-out-alt"></i> Logout
    </button>

    <div class="animated-bg-elements">
        <div class="circle circle-1"></div>
        <div class="circle circle-2"></div>
        <div class="circle circle-3"></div>
        <div class="square square-1"></div>
        <div class="square square-2"></div>
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
                <li class="active">
                    <a href="${pageContext.request.contextPath}/reports">
                        <i class="fas fa-chart-bar"></i> <span>Reports</span>
                    </a>
                </li>
                
                <li>
                    <a href="${pageContext.request.contextPath}/about">
                        <i class="fas fa-cog"></i> <span>About</span>
                    </a>
                </li>
                <li class="sidebar-logout">
                    <a href="${pageContext.request.contextPath}/logout">
                        <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content reports-bg-icon">
            <div class="header">
                <div class="header-content">
                    <h2 class="animate__animated animate__fadeInDown">Reports & Analytics</h2>
                    <div class="breadcrumbs animate__animated animate__fadeIn animate__delay-1s">
                        <span>Dashboard</span> / <span class="active">Reports</span>
                    </div>
                </div>
                <div class="user-menu animate__animated animate__fadeIn">
                    <div class="user-avatar">
                        ${fn:substring(sessionScope.user.username, 0, 1)}
                    </div>
                    
                </div>
            </div>

            <div class="card report-filters animate__animated animate__fadeIn animate__delay-1s">
                <div class="card-header">
                    <h3><i class="fas fa-filter"></i> Filter Reports</h3>
                    <div class="card-actions">
                        <button class="btn btn-icon" id="resetFilters">
                            <i class="fas fa-sync-alt"></i> Reset
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <form id="reportFilterForm">
                        <div class="filter-row">
                            <div class="filter-group floating-label">
                                <select name="reportType" id="reportType" class="form-control">
                                    <option value="sales" selected>Sales Report</option>
                                    <option value="inventory">Inventory Report</option>
                                    <option value="user">User Performance</option>
                                    <option value="category">Category Analysis</option>
                                </select>
                                <label>Report Type</label>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="filter-group floating-label">
                                <select name="dateRange" id="dateRange" class="form-control">
                                    <option value="today" selected>Today</option>
                                    <option value="yesterday">Yesterday</option>
                                    <option value="week">This Week</option>
                                    <option value="month">This Month</option>
                                    <option value="quarter">This Quarter</option>
                                    <option value="year">This Year</option>
                                    <option value="custom">Custom Range</option>
                                </select>
                                <label>Date Range</label>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="filter-group floating-label" id="customDateRange" style="display: none;">
                                <div class="date-range-inputs">
                                    <div class="input-with-icon">
                                        <input type="date" name="startDate" class="form-control">
                                        <i class="fas fa-calendar-alt"></i>
                                    </div>
                                    <span class="date-range-separator">to</span>
                                    <div class="input-with-icon">
                                        <input type="date" name="endDate" class="form-control">
                                        <i class="fas fa-calendar-alt"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="filter-row">
                            <div class="filter-group floating-label">
                                <select name="groupBy" class="form-control">
                                    <option value="day" selected>Day</option>
                                    <option value="week">Week</option>
                                    <option value="month">Month</option>
                                    <option value="year">Year</option>
                                    <option value="category">Category</option>
                                    <option value="product">Product</option>
                                    <option value="user">User</option>
                                </select>
                                <label>Group By</label>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="filter-group floating-label">
                                <select name="sortBy" class="form-control">
                                    <option value="date" selected>Date</option>
                                    <option value="amount">Amount</option>
                                    <option value="quantity">Quantity</option>
                                </select>
                                <label>Sort By</label>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="filter-group floating-label">
                                <select name="order" class="form-control">
                                    <option value="asc">Ascending</option>
                                    <option value="desc" selected>Descending</option>
                                </select>
                                <label>Order</label>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                        </div>
<!--                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary btn-icon">
                                <i class="fas fa-chart-line"></i> Generate Report
                            </button>
                            <button type="button" id="exportReport" class="btn btn-outline btn-icon">
                                <i class="fas fa-file-export"></i> Export
                            </button>
                        </div> -->
                    </form>
                </div>
            </div>

            <div class="report-summary">
                <div class="summary-card animate__animated animate__fadeInLeft">
                    <div class="summary-icon bg-gradient-blue">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="summary-content">
                        <div class="summary-value">LKR ${totalSales}</div>
                        <div class="summary-label">Total Sales</div>
                        <div class="summary-trend up">
                            <i class="fas fa-arrow-up"></i> 12.5%
                        </div>
                    </div>
                </div>
                <div class="summary-card animate__animated animate__fadeInLeft animate__delay-1s">
                    <div class="summary-icon bg-gradient-green">
                        <i class="fas fa-boxes"></i>
                    </div>
                    <div class="summary-content">
                        <div class="summary-value">${totalProductsSold}</div>
                        <div class="summary-label">Products Sold</div>
                        <div class="summary-trend up">
                            <i class="fas fa-arrow-up"></i> 8.2%
                        </div>
                    </div>
                </div>
                <div class="summary-card animate__animated animate__fadeInLeft animate__delay-2s">
                    <div class="summary-icon bg-gradient-orange">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="summary-content">
                        <div class="summary-value">${activeCashiers}</div>
                        <div class="summary-label">Active Cashiers</div>
                        <div class="summary-trend down">
                            <i class="fas fa-arrow-down"></i> 2.1%
                        </div>
                    </div>
                </div>
                <div class="summary-card animate__animated animate__fadeInLeft animate__delay-3s">
                    <div class="summary-icon bg-gradient-purple">
                        <i class="fas fa-percentage"></i>
                    </div>
                    <div class="summary-content">
                        <div class="summary-value">${growthRate}%</div>
                        <div class="summary-label">Growth Rate</div>
                        <div class="summary-trend up">
                            <i class="fas fa-arrow-up"></i> 4.7%
                        </div>
                    </div>
                </div>
            </div>

            <div class="card report-chart animate__animated animate__fadeIn animate__delay-2s">
                <div class="card-header">
                    <h3><i class="fas fa-chart-bar"></i> Sales Performance</h3>
                    <div class="chart-actions">
                        <div class="chart-period-selector">
                            <button class="period-btn active">7D</button>
                            <button class="period-btn">1M</button>
                            <button class="period-btn">3M</button>
                            <button class="period-btn">1Y</button>
                        </div>
                        <div class="chart-type-selector">
                            <button class="chart-action-btn active" data-chart="bar" title="Bar Chart">
                                <i class="fas fa-chart-bar"></i>
                            </button>
                            <button class="chart-action-btn" data-chart="line" title="Line Chart">
                                <i class="fas fa-chart-line"></i>
                            </button>
                            <button class="chart-action-btn" data-chart="pie" title="Pie Chart">
                                <i class="fas fa-chart-pie"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="chart-container">
                        <canvas id="salesChart"></canvas>
                    </div>
                    <div class="chart-legend">
                        <div class="legend-item">
                            <span class="legend-color" style="background: rgba(33, 28, 132, 0.7)"></span>
                            <span class="legend-label">This Period</span>
                        </div>
                        <div class="legend-item">
                            <span class="legend-color" style="background: rgba(99, 102, 241, 0.5)"></span>
                            <span class="legend-label">Previous Period</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card report-table animate__animated animate__fadeIn animate__delay-3s">
                <div class="card-header">
                    <h3><i class="fas fa-table"></i> Detailed Report</h3>
                    <div class="table-actions">
                        <div class="search-box">
                            <input type="text" placeholder="Search transactions..." class="form-control">
                            <i class="fas fa-search"></i>
                        </div>
                        <div class="table-buttons">
                            <form action="${pageContext.request.contextPath}/reports" method="POST" class="clear-history-form" 
                                  onsubmit="return confirm('WARNING: This will permanently delete ALL sales data. Are you sure?');">
                                <input type="hidden" name="action" value="clearAllData">
                                <button type="submit" class="table-action-btn" title="Clear All Data" style="color: #e74c3c; border-color: #e74c3c;">
                                    <i class="fas fa-trash-alt"></i> Clear Data
                                </button>
                            </form>
                            
                            <button class="table-action-btn" id="printReport" title="Print">
                                <i class="fas fa-print"></i>
                            </button>
                            <button class="table-action-btn" id="downloadReport" title="Download CSV">
                                <i class="fas fa-download"></i>
                            </button>
                            <button class="table-action-btn" id="refreshData" title="Refresh">
                                <i class="fas fa-sync-alt"></i>
                            </button>
                                  <div class="report-actions" style="display: flex; justify-content: flex-end; align-items: center; gap: 8px;">
    <div class="search-container">
        <input type="text" placeholder="Search transactions...">
    </div>

  <form action="${pageContext.request.contextPath}/ReportServlet" method="POST" style="margin: 0;" onsubmit="return confirm('Are you sure?');">
    <input type="hidden" name="action" value="clearHistory">
    <button type="submit" class="btn-clear">
        <i class="fas fa-trash-alt"></i> Clear History
    </button>
</form>

    <button class="icon-btn"><i class="fas fa-print"></i></button>
    <button class="icon-btn"><i class="fas fa-download"></i></button>
</div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Date <i class="fas fa-sort"></i></th>
                                    <th>Transaction ID <i class="fas fa-sort"></i></th>
                                    <th>Cashier <i class="fas fa-sort"></i></th>
                                    <th>Items</th>
                                    <th>Subtotal <i class="fas fa-sort"></i></th>
                                    <th>Tax <i class="fas fa-sort"></i></th>
                                    <th>Total <i class="fas fa-sort"></i></th>
                                    <th>Payment</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${sales}" var="sale">
                                <tr class="animate__animated animate__fadeIn">
                                    <td>${sale.date}</td>
                                    <td><span class="badge badge-light">#${sale.id}</span></td>
                                    <td>
                                        <div class="user-avatar-small">
                                            ${fn:substring(sale.cashier, 0, 1)}
                                        </div>
                                        ${sale.cashier}
                                    </td>
                                    <td>${sale.items}</td>
                                    <td>LKR ${sale.subtotal}</td>
                                    <td>LKR ${sale.tax}</td>
                                    <td><strong>LKR ${sale.total}</strong></td>
                                    <td><span class="badge ${sale.paymentMethod == 'Cash' ? 'badge-cash' : 'badge-card'}">${sale.paymentMethod}</span></td>
                                    <td>
                                        <button class="btn-icon btn-view" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="table-footer">
                        <div class="table-info">
                            Showing 1 to 10 of ${fn:length(sales)} entries
                        </div>
                        <div class="pagination">
                            <button class="pagination-btn disabled">
                                <i class="fas fa-chevron-left"></i>
                            </button>
                            <button class="pagination-btn active">1</button>
                            <button class="pagination-btn">2</button>
                            <button class="pagination-btn">3</button>
                            <button class="pagination-btn">
                                <i class="fas fa-chevron-right"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <button class="fab animate__animated animate__fadeInUp animate__delay-4s">
        <i class="fas fa-question"></i>
    </button>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        $(document).ready(function() {
            // Initialize chart with enhanced data
            const ctx = document.getElementById('salesChart').getContext('2d');
            const salesChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [
                        {
                            label: 'This Year',
                            data: [12000, 19000, 3000, 5000, 2000, 3000, 8000, 12000, 9000, 15000, 18000, 22000],
                            backgroundColor: 'rgba(33, 28, 132, 0.7)',
                            borderColor: 'rgba(33, 28, 132, 1)',
                            borderWidth: 1,
                            borderRadius: 6,
                            borderSkipped: false
                        },
                        {
                            label: 'Last Year',
                            data: [10000, 15000, 4000, 6000, 3000, 5000, 7000, 11000, 8000, 13000, 16000, 20000],
                            backgroundColor: 'rgba(99, 102, 241, 0.5)',
                            borderColor: 'rgba(99, 102, 241, 1)',
                            borderWidth: 1,
                            borderRadius: 6,
                            borderSkipped: false
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0,0,0,0.8)',
                            titleFont: {
                                size: 14,
                                weight: 'bold'
                            },
                            bodyFont: {
                                size: 12
                            },
                            padding: 12,
                            cornerRadius: 8,
                            displayColors: true,
                            callbacks: {
                                label: function(context) {
                                    return 'Sales: LKR ' + context.raw.toLocaleString();
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                drawBorder: false,
                                color: 'rgba(0,0,0,0.05)'
                            },
                            ticks: {
                                callback: function(value) {
                                    return 'LKR ' + value.toLocaleString();
                                },
                                padding: 10
                            }
                        },
                        x: {
                            grid: {
                                display: false,
                                drawBorder: false
                            }
                        }
                    },
                    interaction: {
                        intersect: false,
                        mode: 'index'
                    }
                }
            });

            // Chart type switcher with animation
            $('.chart-action-btn').click(function() {
                if (!$(this).hasClass('active')) {
                    $('.chart-action-btn').removeClass('active');
                    $(this).addClass('active');
                    
                    $('.chart-container').addClass('animate__animated animate__flipInX');
                    
                    setTimeout(() => {
                        salesChart.config.type = $(this).data('chart');
                        salesChart.update();
                        $('.chart-container').removeClass('animate__animated animate__flipInX');
                    }, 300);
                }
            });

            // Date range toggle
            $('#dateRange').change(function() {
                if ($(this).val() === 'custom') {
                    $('#customDateRange').slideDown(300);
                } else {
                    $('#customDateRange').slideUp(300);
                }
            });

            // Floating label effect
            $('.floating-label select').on('focus blur', function() {
                $(this).parent().toggleClass('focused', $(this).is(':focus') || $(this).val() !== '');
            }).trigger('blur');

            // Feedback handlers
            $('#exportReport').click(function() {
                showToast('Report exported successfully!', 'success');
            });

            $('#printReport').click(function() {
                window.print();
            });

            // Toast helper
            function showToast(message, type) {
                const icon = type === 'success' ? 'fa-check-circle' : 'fa-info-circle';
                const toast = $(`
                    <div class="toast toast-${type} animate__animated animate__fadeInUp">
                        <div class="toast-icon"><i class="fas ${icon}"></i></div>
                        <div class="toast-message">${message}</div>
                    </div>
                `);
                $('body').append(toast);
                setTimeout(() => toast.remove(), 3000);
            }
        });
    </script>
</body>
</html>