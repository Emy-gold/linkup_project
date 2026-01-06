<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Linkup - Welcome Page</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet"/>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#3ea721",
                        "primary-dark": "#2e8018",
                        "background-light": "#f8fafc",
                        "background-dark": "#0f172a",
                        "surface-light": "#ffffff",
                        "surface-dark": "#1e293b",
                    },
                    fontFamily: {
                        sans: ["Inter", "sans-serif"],
                    },
                    borderRadius: {
                        DEFAULT: "0.5rem",
                    },
                },
            },
        };
    </script>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-800 dark:text-slate-200 font-sans min-h-screen flex flex-col transition-colors duration-300">
    <nav class="sticky top-0 z-50 backdrop-blur-md bg-surface-light/80 border-b border-slate-200">
        <div class="max-w-8xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex-shrink-0 flex items-center">
                    <img
                            src="${pageContext.request.contextPath}/assets/logo.png"
                            class="h-16 w-auto"
                            alt="linkup">
                </div>
                <div class="flex items-center space-x-4">
                    <a href="login.jsp" class="text-sm font-medium text-slate-600 hover:text-slate-900 transition-colors pointer cursor-pointer">Log In </a>
                    <a href="signup.jsp" class="inline-flex items-center justify-center px-5 py-2 border-transparent text-sm font-medium rounded-full text-white bg-primary hover:bg-primary-dark transition-colors  shadow-sm hover:shadow-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary cursor-pointer"> Sign up</a>
                </div>
            </div>
        </div>
    </nav>
    <main class="flex-grow flex items-center justify-center relative overflow-hidden px-4">
        <div class="absolute top-0 left-0 w-full h-full overflow-hidden -z-10 pointer-events-none">
            <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-primary/5 w-[80%] h-[80%] rounded-full blur-3xl"></div>
        </div>
        <div class="max-w-3xl mx-auto text-center py-16">
            <h1 class="text-4xl md:text-5xl lg:text-6xl font-extrabold tracking-tight text-slate-900 leading-tight mb-6">
                Your Career,<br/>
                <span class="text-transparent bg-clip-text bg-gradient-to-r from-primary to-green-400">Linked Up </span> To Success.</h1>
            <p class="text-lg md:text-xl text-slate-600 dark:text-slate-300 max-w-xl mx-auto mb-10 leading-relaxed" >The smarter way to navigate your career path. Connect with top employers and showcase your professional profile today.</p>
            <div class="flex flex-col sm:flex-row items-center justify-center space-y-4 sm:space-y-0 sm:space-x-4">
                <a href="signup.jsp" class="w-full sm:w-auto inline-flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-full text-white bg-primary hover:bg-primary-dark transition-all transform hover:-translate-y-0.5 shadow-lg hover:shadow-primary/30" href="#">
                    Sign Up Now
                </a>
                <a href="login.jsp" class="w-full sm:w-auto inline-flex items-center justify-center px-8 py-3 border border-slate-300 dark:border-slate-600 text-base font-medium rounded-full text-slate-700 dark:text-slate-200 bg-surface-light dark:bg-surface-dark hover:bg-slate-50 dark:hover:bg-slate-700 transition-all" href="#">
                    Log In
                </a>
            </div>
        </div>
    </main>
</body>
</html>