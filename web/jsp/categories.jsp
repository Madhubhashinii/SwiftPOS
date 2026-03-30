<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>SwiftPOS - Category Management</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/categories.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
</head>
<body>
    <div class="animated-lines">
        <div class="line line-1"></div>
        <div class="line line-2"></div>
        <div class="line line-3"></div>
    </div>

    <div class="dashboard-container">
        <!-- Premium Animated Sidebar -->
        <div class="sidebar animate__animated animate__fadeInLeft">
            <div class="sidebar-brand">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="SwiftPOS" class="animate__animated animate__rotateIn">
                <span class="animate__animated animate__fadeIn">SwiftPOS</span>
            </div>
            <ul class="sidebar-nav">
                <li>
                    <a href="${pageContext.request.contextPath}/admin_dashboard" class="animate__animated animate__fadeInLeft">
                        <i class="fas fa-tachometer-alt"></i> <span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/users" class="animate__animated animate__fadeInLeft animate__delay-1s">
                        <i class="fas fa-users"></i> <span>Users</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/products" class="animate__animated animate__fadeInLeft animate__delay-2s">
                        <i class="fas fa-boxes"></i> <span>Products</span>
                    </a>
                </li>
                <li class="active animate__animated animate__fadeInLeft animate__delay-3s">
                    <a href="${pageContext.request.contextPath}/categories">
                        <i class="fas fa-tags"></i> <span>Categories</span>
                        <span class="sidebar-notification animate__animated animate__bounceIn">New</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/sales" class="animate__animated animate__fadeInLeft animate__delay-4s">
                        <i class="fas fa-shopping-cart"></i> <span>Sales</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/reports" class="animate__animated animate__fadeInLeft animate__delay-5s">
                        <i class="fas fa-chart-bar"></i> <span>Reports</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/about" class="animate__animated animate__fadeInLeft animate__delay-6s">
                        <i class="fas fa-cog"></i> <span>About</span>
                    </a>
                </li>
                <li class="animate__animated animate__fadeInLeft animate__delay-7s">
                    <a href="${pageContext.request.contextPath}/logout" class="sidebar-logout-btn">
                        <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content categories-bg-icon animate__animated animate__fadeIn">
            <!-- Header with Animated Stats -->
            <div class="header">
                <div>
                    <h2>Category Management</h2>
                    <p>Organize your product catalog efficiently</p>
                </div>
                <div class="user-menu">
                    <div class="user-avatar animate__animated animate__bounceIn">
                        ${fn:substring(sessionScope.user.username, 0, 1)}
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn animate__animated animate__fadeIn">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>

            <!-- Category Stats Cards -->
            <div class="stats-grid animate__animated animate__fadeInUp">
                <div class="stat-card animate__animated animate__fadeInUp animate__delay-1s">
                    <div class="stat-icon categories">
                        <i class="fas fa-tags"></i>
                    </div>
                    <div>
                        <div class="stat-value">${totalCategories}</div>
                        <div class="stat-label">Total Categories</div>
                    </div>
                </div>
                <div class="stat-card animate__animated animate__fadeInUp animate__delay-2s">
                    <div class="stat-icon products">
                        <i class="fas fa-boxes"></i>
                    </div>
                    <div>
                        <div class="stat-value">${totalProducts}</div>
                        <div class="stat-label">Total Products</div>
                    </div>
                </div>
                <div class="stat-card animate__animated animate__fadeInUp animate__delay-3s">
                    <div class="stat-icon active">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div>
                        <div class="stat-value">${activeCategories}</div>
                        <div class="stat-label">Active Categories</div>
                    </div>
                </div>
                <div class="stat-card animate__animated animate__fadeInUp animate__delay-4s">
                    <div class="stat-icon empty">
                        <i class="fas fa-folder-minus"></i>
                    </div>
                    <div>
                        <div class="stat-value">${emptyCategories}</div>
                        <div class="stat-label">Empty Categories</div>
                    </div>
                </div>
            </div>

            <!-- Action Bar with Enhanced Search -->
            <div class="action-bar animate__animated animate__fadeIn">
                <div class="search-box animate__animated animate__fadeInLeft">
                    <input type="text" placeholder="Search categories..." id="categorySearch">
                    <button class="search-btn"><i class="fas fa-search"></i></button>
                </div>
                <div class="view-options animate__animated animate__fadeInRight">
                    <button class="view-option active" data-view="table"><i class="fas fa-table"></i></button>
                    <button class="view-option" data-view="grid"><i class="fas fa-th-large"></i></button>
                    <button class="view-option" data-view="cards"><i class="fas fa-grip-vertical"></i></button>
                </div>
            </div>

            <!-- Table View (Default) -->
            <div id="tableView" class="view-container">
                <div class="card category-card animate__animated animate__fadeInUp">
                    <div class="table-responsive">
                        <table class="table category-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Category</th>
                                    <th>Description</th>
                                    <th>Products</th>
                                    <th>Usage</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${categories}" var="category">
                                <tr class="animate__animated animate__fadeInUp">
                                    <td data-label="ID">${category.id}</td>
                                    <td data-label="Category">
                                        <strong>${category.name}</strong>
                                        <c:if test="${category.featured}">
                                            <span class="category-badge" style="background-color: #FFD700; color: #000;">Featured</span>
                                        </c:if>
                                    </td>
                                    <td data-label="Description">${fn:substring(category.description, 0, 50)}${fn:length(category.description) > 50 ? '...' : ''}</td>
                                    <td data-label="Products">
                                        <span class="category-badge ${category.productCount > 0 ? 'badge-primary' : 'badge-secondary'}">
                                            ${category.productCount} product(s)
                                        </span>
                                    </td>
                                    <td data-label="Usage">
                                        <div class="category-usage">
                                            <div class="category-usage-bar" style="width: ${(category.productCount / maxProductsPerCategory) * 100}%"></div>
                                        </div>
                                    </td>
                                    <td data-label="Actions" class="actions">
                                        <button class="btn btn-sm btn-outline animate__animated animate__fadeIn"
                                                onclick="showEditCategoryForm('${category.id}', '${fn:escapeXml(category.name)}', '${fn:escapeXml(category.description)}', ${category.featured})">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <c:if test="${category.productCount == 0}">
                                            <button class="btn btn-sm btn-danger animate__animated animate__fadeIn"
                                                    onclick="confirmDeleteCategory('${category.id}')">
                                                <i class="fas fa-trash"></i> Delete
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Grid View (Hidden by default) -->
            <div id="gridView" class="view-container" style="display: none;">
                <div class="card category-card animate__animated animate__fadeIn">
                    <div class="category-grid">
                        <c:forEach items="${categories}" var="category">
                        <div class="category-grid-item animate__animated animate__fadeIn">
                            <div class="category-card-header">
                                ${category.name}
                                <span class="category-badge ${category.productCount > 0 ? 'badge-primary' : 'badge-secondary'}">
                                    ${category.productCount}
                                </span>
                            </div>
                            <div class="category-card-body">
                                <p>${fn:substring(category.description, 0, 100)}${fn:length(category.description) > 100 ? '...' : ''}</p>
                                <div class="category-usage">
                                    <div class="category-usage-bar" style="width: ${(category.productCount / maxProductsPerCategory) * 100}%"></div>
                                </div>
                                <div class="category-actions">
                                    <button class="btn btn-sm btn-outline"
                                            onclick="showEditCategoryForm('${category.id}', '${fn:escapeXml(category.name)}', '${fn:escapeXml(category.description)}', ${category.featured})">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <c:if test="${category.productCount == 0}">
                                        <button class="btn btn-sm btn-danger"
                                                onclick="confirmDeleteCategory('${category.id}')">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Add Category Floating Button -->
            <div class="fab-add-category animate__animated animate__bounceIn" onclick="showAddCategoryForm()">
                <i class="fas fa-plus"></i>
            </div>

            <!-- Add Category Form Modal -->
            <div id="addCategoryModal" class="modal animate__animated">
                <div class="modal-content card">
                    <span class="close" onclick="hideAddCategoryForm()">&times;</span>
                    <h3>Add New Category</h3>
                    <form id="addCategoryForm" action="${pageContext.request.contextPath}/categories?action=add" method="POST">
                        <div class="form-group">
                            <label>Category Name</label>
                            <input type="text" name="categoryName" required class="form-control animate__animated animate__fadeIn">
                        </div>
                        <div class="form-group">
                            <label>Description</label>
                            <textarea name="description" class="form-control animate__animated animate__fadeIn" rows="3"></textarea>
                        </div>
                        <div class="form-group animate__animated animate__fadeIn">
                            <label>
                                <input type="checkbox" name="featured"> Featured Category
                            </label>
                        </div>
                        <div class="form-actions animate__animated animate__fadeInUp">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Category
                            </button>
                            <button type="button" class="btn btn-outline" onclick="hideAddCategoryForm()">
                                <i class="fas fa-times"></i> Cancel
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Edit Category Modal -->
            <div id="editCategoryModal" class="modal animate__animated">
                <div class="modal-content card">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <h3>Edit Category</h3>
                    <form id="editForm" action="${pageContext.request.contextPath}/categories?action=update" method="POST">
                        <input type="hidden" id="editCategoryId" name="id">
                        <div class="form-group">
                            <label>Category Name</label>
                            <input type="text" id="editCategoryName" name="categoryName" required class="form-control animate__animated animate__fadeIn">
                        </div>
                        <div class="form-group">
                            <label>Description</label>
                            <textarea id="editCategoryDescription" name="description" class="form-control animate__animated animate__fadeIn" rows="3"></textarea>
                        </div>
                        <div class="form-group animate__animated animate__fadeIn">
                            <label>
                                <input type="checkbox" id="editCategoryFeatured" name="featured"> Featured Category
                            </label>
                        </div>
                        <div class="form-actions animate__animated animate__fadeInUp">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                            <button type="button" class="btn btn-outline" onclick="closeModal()">
                                <i class="fas fa-times"></i> Cancel
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Delete Confirmation Modal -->
            <div id="deleteConfirmModal" class="modal animate__animated">
                <div class="modal-content card small-modal">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <h3>Confirm Deletion</h3>
                    <p>Are you sure you want to delete this category? This action cannot be undone.</p>
                    <form id="deleteForm" action="${pageContext.request.contextPath}/categories?action=delete" method="POST">
                        <input type="hidden" id="deleteCategoryId" name="id">
                        <div class="form-actions">
                            <button type="submit" class="btn btn-danger animate__animated animate__headShake">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                            <button type="button" class="btn btn-outline animate__animated animate__fadeIn" onclick="closeModal()">
                                <i class="fas fa-times"></i> Cancel
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        // Initialize animations and interactions
        $(document).ready(function() {
            // Animate elements on page load
            $('.category-table tbody tr').each(function(i) {
                $(this).css('animation-delay', (i * 0.1) + 's');
            });
            
            // View switcher
            $('.view-option').click(function() {
                $('.view-option').removeClass('active');
                $(this).addClass('active');
                $('.view-container').hide();
                
                const view = $(this).data('view');
                $('#' + view + 'View').fadeIn();
                
                // Animate the switch
                $('#' + view + 'View .animate__animated').addClass('animate__fadeIn');
            });
            
            // Search functionality
            $('#categorySearch').on('keyup', function() {
                const searchTerm = $(this).val().toLowerCase();
                $('.category-table tbody tr, .category-grid-item').each(function() {
                    const text = $(this).text().toLowerCase();
                    $(this).toggle(text.includes(searchTerm));
                });
            });
        });
        
        // Form Toggle Functions with animations
        function showAddCategoryForm() {
            $('#addCategoryModal').removeClass().addClass('modal animate__animated animate__fadeIn').show();
            $('body').css('overflow', 'hidden');
        }
        
        function hideAddCategoryForm() {
            $('#addCategoryModal').removeClass().addClass('modal animate__animated animate__fadeOut');
            setTimeout(() => {
                $('#addCategoryModal').hide();
                $('body').css('overflow', 'auto');
            }, 300);
        }
        
        // Edit Category Functions with animations
        function showEditCategoryForm(id, name, description, featured) {
            $('#editCategoryId').val(id);
            $('#editCategoryName').val(name);
            $('#editCategoryDescription').val(description || '');
            $('#editCategoryFeatured').prop('checked', featured);
            
            $('#editCategoryModal').removeClass().addClass('modal animate__animated animate__fadeIn').show();
            $('body').css('overflow', 'hidden');
        }
        
        // Delete Confirmation Functions with animations
        function confirmDeleteCategory(id) {
            $('#deleteCategoryId').val(id);
            $('#deleteConfirmModal').removeClass().addClass('modal animate__animated animate__fadeIn').show();
            $('body').css('overflow', 'hidden');
            
            // Add attention animation to delete button
            setTimeout(() => {
                $('#deleteConfirmModal .btn-danger').addClass('animate__headShake');
            }, 500);
        }
        
        function closeModal() {
            $('.modal').removeClass().addClass('modal animate__animated animate__fadeOut');
            setTimeout(() => {
                $('.modal').hide();
                $('body').css('overflow', 'auto');
            }, 300);
        }
        
        // Close modal when clicking outside
        $(window).click(function(event) {
            if ($(event.target).hasClass('modal')) {
                closeModal();
            }
        });
        
        // Hover effects for category cards
        $('.category-card, .category-grid-item').hover(
            function() {
                $(this).addClass('animate__pulse');
            },
            function() {
                $(this).removeClass('animate__pulse');
            }
        );
    </script>
</body>
</html>