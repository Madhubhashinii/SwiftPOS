<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>SwiftPOS - Login</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
     <div class="animated-lines">
            <div class="line line-1"></div>
            <div class="line line-2"></div>
            <div class="line line-3"></div>
        </div>
    
    
    <div class="login-gradient-bg">
       
         <div class="login-frame fade-in">
            
            <!-- Left Side: Login Form -->
            <div class="login-content">
                <h1 class="slide-down">Welcome Back!</h1>
                <p class="subtext fade-in-delay">Please enter login details below</p>
                
                <form action="${pageContext.request.contextPath}/login" method="POST" class="form-animate">
                    <div class="input-group slide-up">
                        <label>Username</label>
                        <input type="text" name="username" required class="input-field">
                    </div>
                    
                    <div class="input-group slide-up">
                        <label>Password</label>
                        <input type="password" name="password" required class="input-field">
                    </div>
                    
                    <button type="submit" class="signin-btn pulse-hover">Sign In</button>
                </form>
                
                <a href="#" class="forgot-link fade-in-delay" style="margin-top: 10px; display: inline-block; color: #333; text-decoration: none;">Forgot password?</a>
                
                <div style="margin-top: 20px; text-align: center;">
                    <p style="margin-bottom: 10px;">or continue</p>
                    <button style="padding: 10px 20px; border-radius: 8px; border: 1px solid #ccc; background: #fff; cursor: pointer;">
                        <img src="https://img.icons8.com/color/24/000000/google-logo.png" style="vertical-align: middle; margin-right: 8px;"/> 
                        Log in with Google
                    </button>
                    <p> </p>
                    
                </div>
            </div>
            
            <!-- Right Side: Animated Illustration -->
            <div class="illustration-container">
                <img src="${pageContext.request.contextPath}/images/login-illustration.png" 
                     alt="POS Illustration" 
                     class="illustration-float">
            </div>
                     
            
     
        </div>
    </div>
        
                     
</body>
</html>
