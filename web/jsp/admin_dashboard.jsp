<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>SwiftPOS - Admin Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        /* Recent Activity Styling */
        .activity-card {
            min-width: 320px;
            background: white;
            border-radius: 12px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid rgba(0,0,0,0.05) !important;
        }
        
        .activity-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
        }

        .activity-icon-container {
            width: 45px;
            height: 45px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            background-color: #f0f2f5;
            color: #4e73df;
        }

        /* Smooth Scrollbar for horizontal activity */
        .horizontal-scroll {
            display: flex;
            flex-nowrap: nowrap;
            overflow-x: auto;
            padding: 10px 5px 20px 5px;
            gap: 20px;
            scrollbar-width: thin;
        }

        .horizontal-scroll::-webkit-scrollbar {
            height: 6px;
        }
        .horizontal-scroll::-webkit-scrollbar-thumb {
            background: #ccc;
            border-radius: 10px;
        }
        
       /* ===== Recent Activity Section ===== */

.horizontal-scroll {
    display: flex;
    gap: 1.5rem;
    overflow-x: auto;
    padding: 1rem 0.25rem 2rem;
    scroll-behavior: smooth;
    scrollbar-width: none;
}

.horizontal-scroll::-webkit-scrollbar {
    display: none;
}

/* Activity Card */
.activity-card {
    min-width: 300px;
    background: rgba(255, 255, 255, 0.88);
    backdrop-filter: blur(12px);
    border-radius: 18px;
    padding: 1.5rem;
    position: relative;
    box-shadow: 0 8px 20px rgba(78, 115, 223, 0.12);
    transition: all 0.35s ease;
    border: 1px solid rgba(255, 255, 255, 0.6);
}

/* Gradient accent line */
.activity-card::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    height: 5px;
    width: 100%;
    background: linear-gradient(90deg, #4e73df, #6f42c1);
    border-radius: 18px 18px 0 0;
}

/* Hover effect */
.activity-card:hover {
    transform: translateY(-6px) scale(1.01);
    box-shadow: 0 16px 30px rgba(78, 115, 223, 0.25);
}

/* Icon circle */
.activity-icon-circle {
    width: 44px;
    height: 44px;
    border-radius: 50%;
    background: linear-gradient(135deg, #4e73df, #6f42c1);
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
    font-size: 1.1rem;
    flex-shrink: 0;
    box-shadow: 0 6px 15px rgba(111, 66, 193, 0.35);
}

/* Text */
.activity-details h6 {
    font-size: 0.95rem;
    font-weight: 600;
    color: #2e2e2e;
    margin-bottom: 6px;
}

.activity-meta {
    font-size: 0.78rem;
    color: #6c757d;
    display: flex;
    align-items: center;
    gap: 6px;
}

.activity-meta i {
    font-size: 0.75rem;
    color: #4e73df;
}

/* Empty state */
.activity-empty {
    min-width: 100%;
    background: rgba(255, 255, 255, 0.85);
    border-radius: 18px;
    padding: 3rem 1rem;
    text-align: center;
    color: #858796;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
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
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="SwiftPOS Logo">
                <span>SwiftPOS</span>
            </div>
            <ul class="sidebar-nav">
                <li class="active">
                    <a href="${pageContext.request.contextPath}/admin_dashboard">
                        <i class="fas fa-tachometer-alt"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/users">
                        <i class="fas fa-users"></i>
                        <span>Users</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/products">
                        <i class="fas fa-boxes"></i>
                        <span>Products</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/categories">
                        <i class="fas fa-tags"></i>
                        <span>Categories</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/sales">
                        <i class="fas fa-shopping-cart"></i>
                        <span>Sales</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/reports">
                        <i class="fas fa-chart-bar"></i>
                        <span>Reports</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/about">
                        <i class="fas fa-cog"></i>
                        <span>About</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content">
            <div class="dashboard-header">
                <div>
                    <h2>Dashboard Overview</h2>
                    <p>Welcome back, ${sessionScope.user.username}!</p>
                </div>
                <div class="user-menu">
                    <div class="user-avatar">
                        ${fn:toUpperCase(fn:substring(sessionScope.user.username, 0, 1))}
                    </div>
                    <div>
                        <div class="user-name">${sessionScope.user.username}</div>
                    </div>
                </div>
            </div>

            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon sales"><i class="fas fa-shopping-cart"></i></div>
                    <div>
                        <div class="stat-value">LKR ${todaySales}</div>
                        <div class="stat-label">Today's Sales</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon products"><i class="fas fa-boxes"></i></div>
                    <div>
                        <div class="stat-value">${totalProducts}</div>
                        <div class="stat-label">Total Products</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon users"><i class="fas fa-users"></i></div>
                    <div>
                        <div class="stat-value">${activeUsers}</div>
                        <div class="stat-label">Active Users</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon revenue"><i class="fas fa-chart-line"></i></div>
                    <div>
                        <div class="stat-value">LKR ${monthRevenue}</div>
                        <div class="stat-label">Monthly Revenue</div>
                    </div>
                </div>
            </div>

            <h3 class="section-title">
                <i class="fas fa-bolt"></i> Quick Actions
            </h3>
            <div class="quick-actions">
                <div class="action-btn" onclick="location.href='${pageContext.request.contextPath}/sales'">
                    <div class="action-icon"><i class="fas fa-cash-register"></i></div>
                    <div class="action-label">New Sale</div>
                </div>
                
                <div class="action-btn" onclick="location.href='${pageContext.request.contextPath}/products'">
                    <div class="action-icon"><i class="fas fa-plus-circle"></i></div>
                    <div class="action-label">Add Product</div>
                </div>
                
                <div class="action-btn" onclick="location.href='${pageContext.request.contextPath}/users?action=new'">
                    <div class="action-icon"><i class="fas fa-user-plus"></i></div>
                    <div class="action-label">Add User</div>
                </div>
                
                <div class="action-btn" onclick="location.href='${pageContext.request.contextPath}/reports'">
                    <div class="action-icon"><i class="fas fa-file-alt"></i></div>
                    <div class="action-label">Generate Report</div>
                </div>
            </div>

           <div class="mt-5 px-3">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="section-title m-0">
            <i class="fas fa-history text-primary me-2"></i> Recent Activity
        </h3>
        <small class="text-muted">Scroll to see more &rightarrow;</small>
    </div>
    
 

    <div class="horizontal-scroll">
    <c:forEach var="activity"
               items="${recentActivities}"
               begin="0"
               end="2">

        <div class="activity-card">
            <div class="d-flex align-items-start gap-3">
                <div class="activity-icon-circle">
                    <i class="fas ${activity.icon}"></i>
                </div>

                <div class="activity-details">
                    <h6>${activity.description}</h6>
                    <div class="activity-meta">
                        <span>
                            <i class="fas fa-user"></i> ${activity.user}
                        </span>
                        <span>•</span>
                        <span>
                            <i class="far fa-clock"></i>
                            ${fn:substring(activity.timestamp, 11, 16)}
                        </span>
                    </div>
                </div>
            </div>
        </div>

    </c:forEach>

    <c:if test="${empty recentActivities}">
        <div class="activity-empty">
            <i class="fas fa-ghost fa-3x mb-3 opacity-25"></i>
            <p class="mb-0">No activities recorded yet</p>
        </div>
    </c:if>
</div>

</div>

</div>
        </div>
    </div>
</body>
</html>