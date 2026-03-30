<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>SwiftPOS - About</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- CSS files -->
 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/about.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    
   
       <style>
    body {
        /* This matches the vibrant purple/indigo from your screenshots */
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
        margin: 0;
        padding: 0;
        min-height: 100vh;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* Ensure the container is transparent so the body background shows through */
    .dashboard-container {
        background: transparent !important;
    }

    /* This makes the main content area slightly translucent 
       if you want that "glass" effect from the dashboard */
    .main-content.about-page {
        background: rgba(255, 255, 255, 0.05); /* Very subtle overlay */
        backdrop-filter: blur(5px);
        min-height: 100vh;
    }

    /* Adjusting text colors to be readable against the purple */
    .about-header h1, .about-header .subtitle {
        color: white !important;
        text-shadow: 0 2px 4px rgba(0,0,0,0.2);
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
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-brand">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="SwiftPOS Logo">
                <span>SwiftPOS</span>
            </div>
            <ul class="sidebar-nav">
                <li>
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
                <li class="active">
                    <a href="${pageContext.request.contextPath}/about">
                        <i class="fas fa-cog"></i>
                        <span>About</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/logout" class="sidebar-logout-btn ">
                        <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
                    </a>
                </li>
            </ul>
        </div>


        <div class="main-content about-page">
            <!-- Floating Tech Icons Background -->
            <div class="tech-icons-background">
                <i class="fab fa-java animate-float" style="--delay: 0s; --duration: 8s; --start-pos: 5%"></i>
                <i class="fab fa-js animate-float" style="--delay: 1s; --duration: 10s; --start-pos: 15%"></i>
                <i class="fab fa-html5 animate-float" style="--delay: 2s; --duration: 12s; --start-pos: 25%"></i>
                <i class="fab fa-css3-alt animate-float" style="--delay: 3s; --duration: 9s; --start-pos: 35%"></i>
                <i class="fas fa-database animate-float" style="--delay: 4s; --duration: 11s; --start-pos: 45%"></i>
                <i class="fab fa-git-alt animate-float" style="--delay: 5s; --duration: 13s; --start-pos: 55%"></i>
            </div>

            <div class="about-header animate__animated animate__fadeInDown">
                <h1>About SwiftPOS</h1>
                <p class="subtitle">Revolutionizing Point of Sale Management</p>
            </div>

            <div class="about-content">
                <!-- System Info Card with Morphing Animation -->
                <div class="about-card system-info animate__animated animate__fadeInLeft">
                    <div class="card-icon">
                        <i class="fas fa-laptop-code"></i>
                    </div>
                    <div class="card-content">
                        <h2>System Information</h2>
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label">System Name:</span>
                                <span class="info-value">SwiftPOS</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Version:</span>
                                <span class="info-value">v1.0 (2025)</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Type:</span>
                                <span class="info-value">Point of Sale Management System</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Description Card with Typewriter Effect -->
                <div class="about-card description animate__animated animate__fadeInRight">
                    <div class="card-icon">
                        <i class="fas fa-file-alt"></i>
                    </div>
                    <div class="card-content">
                        <h2>System Description</h2>
                        <p class="typewriter">A web-based POS system built using Java EE, Tomcat, JDBC, and MySQL to manage sales, inventory, and user roles for small and medium-sized businesses. SwiftPOS provides a seamless, intuitive interface for all your retail management needs.</p>
                    </div>
                </div>

                <!-- Technologies Card with Animated Skill Bars -->
                <div class="about-card technologies animate__animated animate__fadeInLeft">
                    <div class="card-icon">
                        <i class="fas fa-code"></i>
                    </div>
                    <div class="card-content">
                        <h2>Technologies Used</h2>
                        <div class="skill-bars">
                            <div class="skill-bar">
                                <div class="skill-name">Java/JSP/Servlets</div>
                                <div class="skill-level" data-level="90"></div>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-name">MySQL/JDBC</div>
                                <div class="skill-level" data-level="85"></div>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-name">HTML5/CSS3</div>
                                <div class="skill-level" data-level="80"></div>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-name">JavaScript</div>
                                <div class="skill-level" data-level="75"></div>
                            </div>
                            <div class="skill-bar">
                                <div class="skill-name">Tomcat</div>
                                <div class="skill-level" data-level="70"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Team Card with Hover Effects -->
                <div class="about-card team animate__animated animate__fadeInRight">
                    <div class="card-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="card-content">
                        <h2>Development Team</h2>
                        <div class="team-members">
                            <div class="team-member">
                                <div class="member-avatar" style="background-color: #4D55CC;">
                                    G
                                </div>
                                <div class="member-info">
                                    <h3>Gaya</h3>
                                    <p>Lead Developer</p>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>

                <!-- University Info Card with Parallax Effect -->
                <div class="about-card university animate__animated animate__fadeInUp">
                    <div class="card-icon">
                        <i class="fas fa-university"></i>
                    </div>
                    <div class="card-content">
                        <h2>University Information</h2>
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label">University:</span>
                                <span class="info-value">NSBM</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Department:</span>
                                <span class="info-value">Department of IT</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Project Type:</span>
                                <span class="info-value">POS System Project</span>
                            </div>
                            <div> <br> </div>
                           
                        </div>
                    </div>
                </div>
            </div>

            <!-- Animated Footer -->
            <div class="about-footer animate__animated animate__fadeInUp">
                <div class="footer-wave"></div>
                <div class="footer-content">
                    <p>© 2025 SwiftPOS. All rights reserved.</p>
                    <div class="social-links">
                        <a href="#" class="social-link"><i class="fab fa-github"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-linkedin"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            // Animate skill bars on scroll
            $(window).scroll(function() {
                $('.skill-level').each(function() {
                    const level = $(this).data('level');
                    const position = $(this).offset().top;
                    const scroll = $(window).scrollTop();
                    const windowHeight = $(window).height();
                    
                    if (scroll > position - windowHeight + 200) {
                        $(this).css('width', level + '%');
                    }
                });
            });

            // Typewriter effect for description
            const text = $('.typewriter').text();
            $('.typewriter').text('');
            let i = 0;
            const typewriter = setInterval(function() {
                if (i < text.length) {
                    $('.typewriter').append(text.charAt(i));
                    i++;
                } else {
                    clearInterval(typewriter);
                }
            }, 20);

            // Hover effects for team members
            $('.team-member').hover(
                function() {
                    $(this).find('.member-avatar').css('transform', 'scale(1.1) rotate(5deg)');
                },
                function() {
                    $(this).find('.member-avatar').css('transform', 'scale(1) rotate(0)');
                }
            );

            // Parallax effect for university card
            $(window).scroll(function() {
                const scroll = $(window).scrollTop();
                $('.university .card-content').css('transform', 'translateY(' + (scroll * 0.1) + 'px)');
            });
        });
    </script>
</body>
</html>