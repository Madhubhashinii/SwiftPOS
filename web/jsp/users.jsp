<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>SwiftPOS - User Management</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/users.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
                <li class="active">
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
                <li> 
                    <a href="${pageContext.request.contextPath}/about">
                        <i class="fas fa-cog"></i> <span>About</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content">
            <div class="dashboard-header">
                <h2>User Management</h2>
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
                <button class="btn btn-primary" onclick="showAddUserForm()">
                    <i class="fas fa-user-plus"></i> Add New User
                </button>
                <div class="search-box">
                    <input type="text" placeholder="Search users..." id="userSearch">
                    <button class="search-btn"><i class="fas fa-search"></i></button>
                </div>
            </div>

            <%-- Error Message Display --%>
            <c:if test="${not empty error}">
                <div style="color: #ff4d4d; background: #ffe6e6; padding: 10px; border-radius: 5px; margin-bottom: 20px; border: 1px solid #ffcccc;">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <div id="addUserForm" class="card form-container" style="display: none;">
                <h3>Add New User</h3>
                <form action="${pageContext.request.contextPath}/users?action=add" method="POST">
                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" name="username" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" name="password" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label>Role</label>
                        <select name="role" class="form-control">
                            <option value="Admin">Admin</option>
                            <option value="Cashier">Cashier</option>
                        </select>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Save User</button>
                        <button type="button" class="btn btn-outline" onclick="hideAddUserForm()">Cancel</button>
                    </div>
                </form>
            </div>

            <div class="card">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${users}" var="user">
                            <tr>
                                <td data-label="ID">${user.id}</td>
                                <td data-label="Username">${user.username}</td>
                                <td data-label="Role">
                                    <span class="badge ${user.role == 'Admin' ? 'badge-primary' : 'badge-success'}">
                                        ${user.role}
                                    </span>
                                </td>
                                <td data-label="Actions" class="actions">
                                    <button class="btn btn-sm btn-outline"
                                            onclick="showEditForm('${user.id}', '${user.username}', '${user.role}')">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="btn btn-sm btn-outline"
                                            onclick="confirmReset('${user.id}')">
                                        <i class="fas fa-key"></i> Reset Pass
                                    </button>
                                    <c:if test="${user.id != sessionScope.user.id}">
                                        <button class="btn btn-sm btn-danger"
                                                onclick="confirmDelete('${user.id}')">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div id="editUserModal" class="modal">
                <div class="modal-content card">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <h3>Edit User</h3>
                    <form id="editForm" action="${pageContext.request.contextPath}/users?action=update" method="POST">
                        <input type="hidden" id="editUserId" name="id">
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" id="editUsername" name="username" required class="form-control">
                        </div>
                        <div class="form-group">
                            <label>Role</label>
                            <select id="editUserRole" name="role" class="form-control">
                                <option value="Admin">Admin</option>
                                <option value="Cashier">Cashier</option>
                            </select>
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

    <script>
        // --- Put it right here, at the end of your script section ---

    // Function to filter the table rows
    function performSearch() {
        const searchTerm = document.getElementById('userSearch').value.toLowerCase();
        const rows = document.querySelectorAll('.table tbody tr');
        
        rows.forEach(row => {
            // Cell 1 is Username, Cell 2 is Role
            const username = row.cells[1].textContent.toLowerCase();
            const role = row.cells[2].textContent.toLowerCase();
            
            if (username.includes(searchTerm) || role.includes(searchTerm)) {
                row.style.display = ''; 
            } else {
                row.style.display = 'none';
            }
        });
    }

    // Option 1: Live search (as you type)
    document.getElementById('userSearch').addEventListener('input', performSearch);

    // Option 2: Enter key press (formal search)
    document.getElementById('userSearch').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault(); // Prevents the page from reloading
            performSearch();
        }
    });
        // Form Toggle Functions
        function showAddUserForm() {
            document.getElementById('addUserForm').style.display = 'block';
        }
        
        function hideAddUserForm() {
            document.getElementById('addUserForm').style.display = 'none';
        }
        
        // Edit User Functions
        function showEditForm(id, username, role) {
            document.getElementById('editUserId').value = id;
            document.getElementById('editUsername').value = username;
            document.getElementById('editUserRole').value = role;
            document.getElementById('editUserModal').style.display = 'block';
        }
        
        function closeModal() {
            document.getElementById('editUserModal').style.display = 'none';
        }
        
        // Confirmation Dialogs
        function confirmReset(userId) {
            if(confirm('Reset password for user ID ' + userId + ' to default?')) {
                window.location.href = '${pageContext.request.contextPath}/users?action=reset&id=' + userId;
            }
        }
        
        function confirmDelete(userId) {
            if(confirm('Permanently delete this user?')) {
                window.location.href = '${pageContext.request.contextPath}/users?action=delete&id=' + userId;
            }
        }
        
        // Search Functionality
        document.getElementById('userSearch').addEventListener('keyup', function(e) {
            if(e.key === 'Enter') {
                const searchTerm = this.value.toLowerCase();
                const rows = document.querySelectorAll('.table tbody tr');
                
                rows.forEach(row => {
                    const username = row.cells[1].textContent.toLowerCase();
                    const role = row.cells[2].textContent.toLowerCase();
                    row.style.display = (username.includes(searchTerm) || role.includes(searchTerm) ? '' : 'none');
                });
            }
        });
    </script>
</body>
</html>