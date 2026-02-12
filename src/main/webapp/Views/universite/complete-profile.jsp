<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <title>Compléter Profil Université - LinkUp</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
            rel="stylesheet" />
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
        </style>
    </head>

    <body class="bg-gray-50 min-h-screen">
        <div class="flex flex-col justify-center py-12 sm:px-6 lg:px-8">
            <div class="sm:mx-auto sm:w-full sm:max-w-md">
                <div class="flex justify-center mb-4">
                    <span class="material-icons text-5xl text-green-600">account_balance</span>
                </div>
                <h2 class="text-center text-3xl font-extrabold text-gray-900">
                    Informations de l'Université
                </h2>
                <p class="mt-2 text-center text-sm text-gray-600">
                    Veuillez renseigner les détails de votre établissement avant de commencer.
                </p>
            </div>

            <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
                <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10 border border-gray-100">
                    <% if (request.getAttribute("error") !=null) { %>
                        <div class="mb-4 bg-red-50 border-l-4 border-red-400 p-4 text-red-700">
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>

                            <form class="space-y-6" action="universite-complete-profile" method="POST">
                                <div>
                                    <label for="nomUniversite" class="block text-sm font-medium text-gray-700">Nom de
                                        l'Université</label>
                                    <div class="mt-1">
                                        <input id="nomUniversite" name="nomUniversite" type="text" required
                                            class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-green-500 focus:border-green-500 sm:text-sm"
                                            placeholder="ex: Université Mohammed V">
                                    </div>
                                </div>

                                <div>
                                    <label for="adresse" class="block text-sm font-medium text-gray-700">Adresse</label>
                                    <div class="mt-1">
                                        <input id="adresse" name="adresse" type="text" required
                                            class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-green-500 focus:border-green-500 sm:text-sm"
                                            placeholder="Adresse complète">
                                    </div>
                                </div>

                                <div>
                                    <label for="telephone"
                                        class="block text-sm font-medium text-gray-700">Téléphone</label>
                                    <div class="mt-1">
                                        <input id="telephone" name="telephone" type="text" required
                                            class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-green-500 focus:border-green-500 sm:text-sm"
                                            placeholder="Numéro de téléphone">
                                    </div>
                                </div>

                                <div>
                                    <label for="emailContact" class="block text-sm font-medium text-gray-700">Email de
                                        Contact</label>
                                    <div class="mt-1">
                                        <input id="emailContact" name="emailContact" type="email" required
                                            class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-green-500 focus:border-green-500 sm:text-sm"
                                            placeholder="contact@universite.ma">
                                    </div>
                                </div>

                                <div>
                                    <button type="submit"
                                        class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition duration-150 ease-in-out">
                                        Enregistrer et continuer
                                    </button>
                                </div>
                            </form>
                </div>
            </div>
        </div>
    </body>

    </html>