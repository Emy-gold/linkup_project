<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
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
                        "background-light": "#F4F4F4",
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
<body class="bg-gradient-to-br from-green-50 via-lime-50 to-emerald-50 min-h-screen font-sans">
<div class="flex justify-center items-center min-h-screen py-12 px-4">
    <div class="w-full max-w-md">
        <!-- Header -->
        <div class="text-center mb-8">
            <h2 class="text-3xl font-bold text-gray-800 mb-2">Login</h2>
            <p class="text-gray-600">Welcome back! Please sign in to continue</p>
        </div>

        <!-- Form Card -->
        <div class="bg-white rounded-2xl shadow-xl p-8 border border-gray-100">
            <form action="login" method="post" class="space-y-5">
                <!-- Email Field -->
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                            <span class="flex items-center gap-2">
                                <span class="material-icons text-sm" style="color: #3ea721;">email</span>
                                Email
                            </span>
                    </label>
                    <input
                            name="email"
                            type="email"
                            required
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:border-transparent transition-all duration-200 outline-none"
                            style="--tw-ring-color: #3ea721;"
                            placeholder="your.email@example.com"
                    />
                </div>

                <!-- Password Field -->
                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                            <span class="flex items-center gap-2">
                                <span class="material-icons text-sm" style="color: #3ea721;">lock</span>
                                Password
                            </span>
                    </label>
                    <input
                            name="password"
                            type="password"
                            required
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:border-transparent transition-all duration-200 outline-none"
                            style="--tw-ring-color: #3ea721;"
                            placeholder="Enter your password"
                    />
                </div>

                <!-- Remember Me & Forgot Password -->
                <div class="flex items-center justify-between text-sm">
                    <label class="flex items-center gap-2 cursor-pointer">
                        <input
                                type="checkbox"
                                class="rounded border-gray-300 focus:ring-2 focus:ring-offset-0 cursor-pointer"
                                style="color: #3ea721; --tw-ring-color: #3ea721;"
                        />
                        <span class="text-gray-600">Remember me</span>
                    </label>
                    <a href="#" class="font-semibold hover:underline transition-colors" style="color: #3ea721;">
                        Forgot password?
                    </a>
                </div>

                <!-- Submit Button -->
                <button
                        type="submit"
                        class="w-full text-white font-semibold py-3 px-6 rounded-lg shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition-all duration-200 flex items-center justify-center gap-2 mt-6"
                        style="background-color: #3ea721;"
                        onmouseover="this.style.backgroundColor='#358a1c'"
                        onmouseout="this.style.backgroundColor='#3ea721'"
                >
                    <span>Log in</span>
                    <span class="material-icons">arrow_forward</span>
                </button>
            </form>

            <!-- Additional Links -->
            <div class="mt-6 text-center">
                <p class="text-sm text-gray-600">
                    Don't have an account?
                    <a href="signup.jsp" class="font-semibold hover:underline transition-colors" style="color: #3ea721;">
                        Sign up here
                    </a>
                </p>
            </div>
        </div>

        <!-- Footer -->
        <div class="text-center mt-6">
            <p class="text-xs text-gray-500">
                By logging in, you agree to our Terms of Service and Privacy Policy
            </p>
        </div>
    </div>
</div>
</body>
</html>
